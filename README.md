Tuesmon contrib HipChat
=====================

The Tuesmon plugin for HipChat integration.

Installation
------------
### Production env

#### Tuesmon Back

In your Tuesmon back python virtualenv install the pip package tuesmon-contrib-hipchat with:

```bash
  pip install tuesmon-contrib-hipchat
```

Modify in `tuesmon-back` your `settings/local.py` and include the line:

```python
  INSTALLED_APPS += ["tuesmon_contrib_hipchat"]
```

Then run the migrations to generate the new need table:

```bash
  python manage.py migrate tuesmon_contrib_hipchat
```

#### Tuesmon Front

Download in your `dist/plugins/` directory of Tuesmon front the `tuesmon-contrib-hipchat` compiled code (you need subversion in your system):

```bash
  cd dist/
  mkdir -p plugins
  cd plugins
  svn export "https://github.com/tuesmoncom/tuesmon-contrib-hipchat/tags/$(pip show tuesmon-contrib-hipchat | awk '/^Version: /{print $2}')/front/dist" "hipchat"
```

Include in your 'dist/conf.json' in the 'contribPlugins' list the value `"/plugins/hipchat/hipchat.json"`:

```json
...
    "contribPlugins": [
        (...)
        "/plugins/hipchat/hipchat.json"
    ]
...
```

### Dev env

#### Tuesmon Back

Clone the repo and

```bash
  cd tuesmon-contrib-hipchat/back
  workon tuesmon
  pip install -e .
```

Modify in `tuesmon-back` your `settings/local.py` and include the line:

```python
  INSTALLED_APPS += ["tuesmon_contrib_hipchat"]
```

Then run the migrations to generate the new need table:

```bash
  python manage.py migrate tuesmon_contrib_hipchat
```

#### Tuesmon Front

After clone the repo link `dist` in `tuesmon-front` plugins directory:

```bash
  cd tuesmon-front/dist
  mkdir -p plugins
  cd plugins
  ln -s ../../../tuesmon-contrib-hipchat/dist hipchat
```

Include in your 'dist/conf.json' in the 'contribPlugins' list the value `"/plugins/hipchat/hipchat.json"`:

```json
...
    "contribPlugins": [
        (...)
        "/plugins/hipchat/hipchat.json"
    ]
...
```

In the plugin source dir `tuesmon-contrib-hipchat/front` run

```bash
npm install
```
and use:

- `gulp` to regenerate the source and watch for changes.
- `gulp build` to only regenerate the source.



How to use
----------

Follow the instructions on our support page [Tuesmon.com Support > Contrib Plugins > HipChat integration](https://manage.tuesmon.com/support/contrib-plugins/hipchat-integration/ "Tuesmon.com Support > Contrib Plugins > HipChat integration")
