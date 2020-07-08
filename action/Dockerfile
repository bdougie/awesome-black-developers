FROM ruby:2.5

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN bundle install

COPY . .

CMD ["ruby", "./action/update-photos.rb"]
#CMD ["ls"]
