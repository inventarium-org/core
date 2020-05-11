FROM ruby:2.7.0

RUN apt-get update && apt-get install --assume-yes postgresql postgresql-client
RUN apt-get install git

RUN bundle config --global frozen 1

RUN mkdir /project
WORKDIR /project

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV HANAMI_HOST=0.0.0.0

# ENV RACK_ENV=production
# ENV HANAMI_ENV=production
# ENV SERVE_STATIC_ASSETS='true'

ADD Gemfile /project/Gemfile
ADD Gemfile.lock /project/Gemfile.lock
RUN bundle install --without development test -j 5

ADD . /project/

EXPOSE 2300
