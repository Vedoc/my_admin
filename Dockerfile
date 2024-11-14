# Stage: Builder
FROM ruby:3.3.0-alpine as Builder

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    BUNDLE_WITHOUT="development:test"

ARG RAILS_MASTER_KEY
ARG GIT_CREDENTIALS

ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

# Install required packages
RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
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
    && bundle install -j4 --retry 3 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

# Install yarn packages
COPY package.json yarn.lock .yarnclean /app/
RUN yarn install

# Add the Rails app
COPY . .

# Precompile assets
# RUN bundle exec rake assets:precompile RAILS_ENV=production

# Stage: Final
FROM ruby:3.3.0-alpine

# Install production dependencies only
RUN apk add --update --no-cache \
    postgresql-client \
    postgis \
    imagemagick \
    tzdata \
    file \
    nodejs-current

# Add non-root user
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

# Set working directory
WORKDIR /app

# Copy app with gems from builder stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Copy entrypoint script
COPY --chmod=755 bin/docker-entrypoint /usr/bin/

# Switch to non-root user
USER app

# Expose port
EXPOSE 3001

# Set entrypoint and command
ENTRYPOINT ["docker-entrypoint"]
CMD ["rails", "server", "-b", "0.0.0.0"]
