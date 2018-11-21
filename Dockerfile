FROM python:3.6-alpine
MAINTAINER Ryan <ryan@spotlightcybersecurity.com>
RUN pip3 install pipenv && apk --no-cache add build-base gcc autoconf linux-headers
# This is where Google Cloud Build will auto-mount the source code
WORKDIR /workspace
# Put the virtualenv in the project directory directly (in this case, it'll be
# /workspace/.venv) so that it persists across calls to this container
ENV PIPENV_VENV_IN_PROJECT=true
# Because our entrypoint will be pipenv, pipenv won't be able to automatically
# determine what shell we're in so we help pipenv out by specifying a shell
# manually.
ENV PIPENV_SHELL=/bin/sh
ENTRYPOINT ["pipenv"]
CMD ["install"]
