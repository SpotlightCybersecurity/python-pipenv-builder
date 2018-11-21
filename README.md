This is a Google cloud builder for Python/pienv (although probably useful for other python/pipenv container needs). Useful for your CI/CD needs to install and run Python code and its dependencies. pipenv is the entrypoint and the default command (to pipenv) is `install`.

Without any arguments, it expects to find a Pipfile/Pipfile.lock in `/workspace`.

```bash
docker run --rm -it -v /path/to/yourcode:/workspace spotlightcybersecurity/python-pipenv-builder
```

This will use pipenv to install all dependencies in a virtualenv in `/workspace/.venv`. This location will allow you to retain the virtualenv across calls to this container.

# Manual Use
To run a specific command inside that pipenv shell (in this example, build our `Makefile`):

```bash
docker run --rm -it -v /path/to/yourcode:/workspace spotlightcybersecurity/python-pipenv-builder run make
```

or just launch an interactive shell:

```bash
docker run --rm -it -v /path/to/yourcode:/workspace spotlightcybersecurity/python-pipenv-builder shell
```

# Cloud Build use
For example, to build a pelican blog (assuming the Pipfile already has pelican in it as a dependency from previously running `pipenv install pelican` and then checking in the Pipfile and Pipfile.lock):
```yaml
steps:
  - name: 'spotlightcybersecurity/python-pipenv-builder'
    args: ['install']
  - name: 'spotlightcybersecurity/python-pipenv-builder'
    args: ['run','pelican','content','-o','output','-s','publishconf.py']
  - name: gcr.io/cloud-builders/gcloud
    entrypoint: gsutil
    args: ["-m", "rsync", "-R", "-c", "-d", "./output", "gs://YOURBUCKETHERE"]
```
