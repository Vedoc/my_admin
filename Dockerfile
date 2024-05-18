# Stage: Builder
FROM ruby:3.3.0-alpine as Builder

# Set environment variables
ENV RAILS_ENV=production
ARG RAILS_MASTER_KEY
ARG FOLDERS_TO_REMOVE
ARG BUNDLE_WITHOUT
ARG NODE_ENV
ARG GIT_CREDENTIALS
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}
ENV RAILS_ENV=${RAILS_ENV}
ENV NODE_ENV=${NODE_ENV}
ENV RAILS_SERVE_STATIC_FILES=true

# Install required packages
RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    nodejs-current \
    yarn \
    tzdata

WORKDIR /app

# Create /app/tmp/cache directory and set permissions
RUN mkdir -p /app/tmp/cache && chmod -R 777 /app/tmp/cache

# Install gems
COPY Gemfile* /app/
RUN bundle config frozen false \
    && bundle config "https://github.com/vedoc/vedoc-plugin.git" $GIT_CREDENTIALS \
    && bundle install -j4 --retry 3 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete \
    && find /app/tmp/cache -type f -exec rm {} \;

# Install yarn packages
COPY package.json yarn.lock .yarnclean /app/
RUN yarn install

# Add the Rails app
COPY . .

ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

# Precompile assets
RUN rake assets:precompile

# Copy the startup script and grant executable permission
COPY docker/startup.sh /docker/startup.sh
RUN chmod +x /docker/startup.sh

# Remove folders not needed in resulting image
RUN rm -rf $FOLDERS_TO_REMOVE

# Copy init.sql and entrypoint script
COPY init.sql /docker-entrypoint-initdb.d/
COPY docker/ /docker/

# Stage Final
FROM ruby:3.3.0-alpine

ARG ADDITIONAL_PACKAGES
ARG EXECJS_RUNTIME

# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client \
    imagemagick \
    $ADDITIONAL_PACKAGES \
    tzdata \
    file

# Add user
RUN addgroup -g 1000 -S app \
 && adduser -u 1000 -S app -G app
USER app

# Set working directory
WORKDIR /app

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME $EXECJS_RUNTIME

# Expose Puma port
EXPOSE 3001

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
CMD ["docker/startup.sh"]
