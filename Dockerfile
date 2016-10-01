FROM alpine:3.3
#FROM debian:jessie
MAINTAINER technolengy@gmail.com

RUN apk update && apk --update add ruby ruby-irb ruby-io-console tzdata ca-certificates bash
#RUN apt-get update && apt-get install -y ruby-full bundler

ADD Gemfile /app/  
ADD Gemfile.lock /app/

#RUN cd /app && bundle install

RUN apk --update add --virtual build-deps build-base ruby-dev \
    && gem install bundler --no-ri --no-rdoc \
    && cd /app \
    && bundle install \
    && apk del build-deps

ADD . /app  
RUN chown -R root:root /app  

WORKDIR /app

EXPOSE 25

#CMD ["/app/docker-entrypoint.sh"]
CMD ["bundle", "exec", "ruby", "mail.rb"]
