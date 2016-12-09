# Spinel

A lightweight blog made with Sinatra and ActiveRecord.

**Caution** : This app doesn't support visitors comments, it was made for minimalist blogging purposes.

The views HTML code have little to no css classes to let you customize it according to your personal tastes.

## Installation

* Run `bundle install` in your terminal to install the gems needed.
* Create your development database in postgres.
* Update the `app.rb` file with your postgres credentials and the databases names (developement and production).
* Run `rake db:migrate`
* Run `bundle exec rackup config.ru -p SOME_PORT` and you're ready !

## Features

### Posts management
You can access the `/admin` path to manage your posts and create new ones.

**This path is `http basic` protected** : you can update your authorised credentials in the `helpers/auth_helpers.rb` file.

### Quote generator
I added a quote generator as the blog subtitle, you can find and edit the quotes in `public/quotes.txt`.
Keep in mind that it's one quote per line of the `quotes.txt` file.

### Tux console
You can run the app console in your terminal with the `tux` command.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
