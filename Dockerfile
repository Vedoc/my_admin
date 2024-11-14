# Stage: Builder
FROM ruby:3.3.0-alpine as Builder

ARG RAILS_ENV=production
ARG NODE_ENV=production
ARG EXECJS_RUNTIME=Node
ARG RAILS_MASTER_KEY
ARG GIT_CREDENTIALS

ENV RAILS_ENV=${RAILS_ENV} \
    NODE_ENV=${NODE_ENV} \
    RAILS_SERVE_STATIC_FILES=true \
    BUNDLE_WITHOUT="development:test" \
    RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

# Install required packages
RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    geos-dev \
    proj-dev \
    gdal-dev \
    git \
    nodejs-current \
    yarn \
    tzdata \
    netcat-openbsd

WORKDIR /app

# Create cache directory with proper permissions
RUN mkdir -p /app/tmp/cache && chmod -R 777 /app/tmp/cache

# Install gems
COPY Gemfile* /app/
RUN bundle config frozen false \
    && bundle config "https://github.com/vedoc/vedoc-plugin.git" $GIT_CREDENTIALS \
    && bundle install -j4 --retry 3

# Install yarn packages
COPY package.json yarn.lock .yarnclean /app/
RUN yarn install

# Add the Rails app
COPY . .

# Precompile assets
# RUN SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

# Stage: Final
FROM ruby:3.3.0-alpine

# Install production dependencies
RUN apk add --update --no-cache \
    postgresql-client \
    geos \
    proj \
    gdal \
    tzdata \
    nodejs-current \
    netcat-openbsd

WORKDIR /app

# Copy app with gems from builder
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder /app /app

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD nc -z localhost 3001 || exit 1

# Expose port
EXPOSE 3001

# Copy and set entrypoint
COPY bin/docker-entrypoint /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
