FROM ruby:2.5

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY . .

CMD ["ruby", "./action/create-readme.rb"]
#CMD ["ls"]
