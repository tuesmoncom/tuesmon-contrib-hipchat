###
# Copyright (C) 2014-2017 Andrey Antukh <niwi@niwi.nz>
# Copyright (C) 2014-2017 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014-2017 David Barragán Merino <bameda@dbarragan.com>
# Copyright (C) 2014-2017 Alejandro Alonso <alejandro.alonso@kaleidos.net>
# Copyright (C) 2014-2017 Juan Francisco Alcántara <juanfran.alcantara@kaleidos.net>
# Copyright (C) 2014-2017 Xavi Julian <xavier.julian@kaleidos.net>
# Copyright (C) 2014-2017 Andrea Stagi <stagi.andrea@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: hipchat.coffee
###
debounce = (wait, func) ->
    return _.debounce(func, wait, {leading: true, trailing: false})


class HipChatAdmin
    @.$inject = [
        "$rootScope",
        "$scope",
        "$tgRepo",
        "tgAppMetaService",
        "$tgConfirm",
        "$tgHttp",
        "tgProjectService"
    ]

    constructor: (@rootScope, @scope, @repo, @appMetaService, @confirm, @http, @projectService) ->
        @scope.sectionName = "HipChat" # i18n
        @scope.sectionSlug = "hipchat"

        @scope.project = @projectService.project.toJS()
        @scope.projectId = @scope.project.id

        promise = @repo.queryMany("hipchat", {project: @scope.projectId})

        promise.then (hipchathooks) =>
            @scope.hipchathook = {
                project: @scope.projectId,
                notify_userstory_create: true,
                notify_userstory_change: true,
                notify_userstory_delete: true,
                notify_task_create: true,
                notify_task_change: true,
                notify_task_delete: true,
                notify_issue_create: true,
                notify_issue_change: true,
                notify_issue_delete: true,
                notify_wikipage_create: true,
                notify_wikipage_change: true,
                notify_wikipage_delete: true
            }
            if hipchathooks.length > 0
                @scope.hipchathook = hipchathooks[0]

            title = "#{@scope.sectionName} - Plugins - #{@scope.project.name}" # i18n
            description = @scope.project.description
            @appMetaService.setAll(title, description)

        promise.then null, =>
            @confirm.notify("error")

    testHook: () ->
        promise = @http.post(@repo.resolveUrlForModel(@scope.hipchathook) + '/test')
        promise.success (_data, _status) =>
            @confirm.notify("success")
        promise.error (data, status) =>
            @confirm.notify("error")


HipChatWebhooksDirective = ($repo, $confirm, $loading, $analytics) ->
    link = ($scope, $el, $attrs) ->
        form = $el.find("form").checksley({"onlyOneErrorElement": true})
        submit = debounce 2000, (event) =>
            event.preventDefault()

            return if not form.validate()

            currentLoading = $loading()
                .target(submitButton)
                .start()

            if not $scope.hipchathook.id
                promise = $repo.create("hipchat", $scope.hipchathook)
                promise.then (data) ->
                    $analytics.trackEvent("hipchat", "create", "Create hipchat integration", 1)
                    $scope.hipchathook = data
            else if $scope.hipchathook.url
                promise = $repo.save($scope.hipchathook)
                promise.then (data) ->
                    $scope.hipchathook = data
            else
                promise = $repo.remove($scope.hipchathook)
                promise.then (data) ->
                    $scope.hipchathook = {
                        project: $scope.projectId,
                        notify_userstory_create: true,
                        notify_userstory_change: true,
                        notify_userstory_delete: true,
                        notify_task_create: true,
                        notify_task_change: true,
                        notify_task_delete: true,
                        notify_issue_create: true,
                        notify_issue_change: true,
                        notify_issue_delete: true,
                        notify_wikipage_create: true,
                        notify_wikipage_change: true,
                        notify_wikipage_delete: true
                    }

            promise.then (data)->
                currentLoading.finish()
                $confirm.notify("success")

            promise.then null, (data) ->
                currentLoading.finish()
                form.setErrors(data)
                if data._error_message
                    $confirm.notify("error", data._error_message)

        submitButton = $el.find(".submit-button")

        $el.on "submit", "form", submit
        $el.on "click", ".submit-button", submit

    return {link:link}


module = angular.module('tuesmonContrib.hipchat', [])

module.controller("ContribHipChatAdminController", HipChatAdmin)
module.directive("contribHipchatWebhooks", ["$tgRepo", "$tgConfirm", "$tgLoading", "$tgAnalytics", HipChatWebhooksDirective])

initHipChatPlugin = ($tgUrls) ->
    $tgUrls.update({
        "hipchat": "/hipchat"
    })
module.run(["$tgUrls", initHipChatPlugin])
