FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && \
    apt-get install -y nodejs \
    yarn 

ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./app/Gemfile $APP_ROOT
ADD ./app/Gemfile.lock $APP_ROOT
ADD ./app/package.json $APP_ROOT
ADD ./app/yarn.lock $APP_ROOT

RUN bundle install
RUN yarn install
ADD ./app $APP_ROOT

ADD entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]
