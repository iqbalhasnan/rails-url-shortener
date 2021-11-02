FROM ruby:3.0.2-alpine AS builder

ENV ROOT=/var/www/coingecko \
    BUNDLE_PATH=/var/www/coingecko/vendor/bundle
ENV BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH $ROOT/bin:$BUNDLE_BIN:$PATH

RUN apk update && apk upgrade && apk add --update --no-cache \
  build-base \
  curl-dev \
  nodejs \
  postgresql-dev \
  tzdata \
  yarn && rm -rf /var/cache/apk/*

WORKDIR $ROOT

ENV BUNDLE_WITHOUT development:test
ENV RAILS_ENV production
ENV NODE_ENV production

COPY Gemfile Gemfile.lock package.json yarn.lock ./

RUN bundle install && \
  rm -rf $BUNDLE_PATH/ruby/3.0.0/cache/*.gem && \
  find $BUNDLE_PATH/ruby/3.0.0/gems/ -name "*.c" -delete && \
  find $BUNDLE_PATH/ruby/3.0.0/gems/ -name "*.o" -delete

RUN yarn install --frozen-lockfile --non-interactive --production

COPY . $ROOT

RUN rails assets:precompile --trace && \
  yarn cache clean && \
  rm -rf node_modules tmp/cache vendor/assets test

FROM ruby:3.0.2-alpine

RUN mkdir -p /var/www/coingecko
WORKDIR /var/www/coingecko

ENV RAILS_ENV production
ENV NODE_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV BUNDLE_WITHOUT development:test
ENV BUNDLE_PATH=/var/www/coingecko/vendor/bundle
ENV BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH $ROOT/bin:$BUNDLE_BIN:$PATH

# Some native extensions required by gems such as pg
COPY --from=builder /usr/lib /usr/lib

# Timezone data is required at runtime
COPY --from=builder /usr/share/zoneinfo/ /usr/share/zoneinfo/

# Ruby gems
COPY --from=builder /var/www/coingecko/vendor/bundle /var/www/coingecko/vendor/bundle

COPY --from=builder /var/www/coingecko /var/www/coingecko

RUN [ -f ./geolite/GeoLite2-City.mmdb ] || wget https://github.com/DocSpring/geolite2-city-mirror/raw/master/GeoLite2-City.tar.gz -O - | tar xz --strip-components=1 -C ./geolite

CMD ["sh", "-c", "bundle exec puma -C config/puma.rb"]