# sinatra + sinatra-activerecord (with rspec) template

## About

 * sinatra + sinatra-activerecord sample app.

## How to use

```
$ git clone <this repo>
$ cd sinatra-record-template
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec ruby app.rb
```

## Run test

```
$ bundle exec rake db:create RACK_ENV=test
$ bundle exec rake db:migrate RACK_ENV=test
$ bundle exec rake rspec
```

## Author
Kouki Ooyatsu
