# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tuesmon_contrib_hipchat', '0002_hipchathook_notify'),
    ]

    operations = [
        migrations.AddField(
            model_name='hipchathook',
            name='notify_issue_change',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_issue_create',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_issue_delete',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_task_change',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_task_create',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_task_delete',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_userstory_change',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_userstory_create',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_userstory_delete',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_wikipage_change',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_wikipage_create',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='hipchathook',
            name='notify_wikipage_delete',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
    ]
