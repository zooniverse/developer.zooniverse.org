FROM python:3-alpine

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


LABEL "com.github.actions.name"="Deploy Sphinx sites to Github Pages"
LABEL "com.github.actions.description"="Builds & deploys a Sphinx based project to GitHub Pages"
LABEL "com.github.actions.icon"="globe"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/marten/github-pages-sphinx"

RUN apk --no-cache add git make

ADD entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]