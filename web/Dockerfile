FROM ruby

RUN apt-get update && \
    apt-get install -y build-essential nodejs && \
    gem install redis-browser

EXPOSE 4567

ENTRYPOINT ["redis-browser"]
