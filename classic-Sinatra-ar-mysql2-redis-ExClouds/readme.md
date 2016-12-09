# Sinatra + Resque Example

##### This example contains:
* sinatra server
* resque server
* resque web managment
* activerecords
* rake db task support

## Requirements

1) ruby 1.9.3+

2) mysql (if using mysql as database)

3) redis

## Installation

1) `git clone git@github.com:ExClouds/sinatra_resque_activerecords_example.git`

2) `cd sinatra_resque_activerecords_example`

3) `bundle install`

## Before Running

Before running server, update, what database to use:

* mysql - update `config/database.yml` file
* sqlite - to use sqlite:

	1) remove `config/database.yml`

	2) open file `app.rb` and replace

	`set :database_file, 'config/database.yml'`
        
	with 
        
	`set :database, {adapter: "sqlite3", database: "db_name.sqlite3"}`
    
	3) open `Gemfile` and replace:

	`gem 'mysql'`

	with

	`gem 'sqlite3`

## Run

To run, just execute `foremant start`


## Q&A

#### *How to add background jobs?*

create a new file `jobs` folder, for example, `test_job.rb` and paste:
    
```ruby
module TestJob
  @queue = :test
  def self.perform
 	 p 'resque job ran'
  end
end
```
    
    
Remember to change `file name` to match `module` name and `@queue`.


#### *How to add models?*

 create a new file in `models` folder, for example, `user.rb`, and paste:

```ruby
class User < ActiveRecord::Base
  # validates_presence_of :name
end
```


#### *How to add initializers / custom libraries?*

To add initializer, add the ruby (*.rb) file to `config/initializers` folder.

To add custom library, copy it to `lib` folder.

#### *Need more workers?*

Open up `Procfile` and add `resque2: rake jobs:work`.


#### *How to use rack database commands?*

  * **rake db:create**            - Create the database from DATABASE_URL or config/database.yml for the current Rails.env (use db:create:all to create all dbs in the config)
  * **rake db:create_migration**  - Create a migration (parameters: NAME, VERSION)
  * **rake db:drop**              - Drops the database using DATABASE_URL or the current Rails.env (use db:drop:all to drop all databases)
  * **rake db:fixtures:load**     - Load fixtures into the current environment's database
  * **rake db:migrate**           - Migrate the database (options: VERSION=x, VERBOSE=false)
  * **rake db:migrate:status**    - Display status of migrations
  * **rake db:rollback**          - Rolls the schema back to the previous version (specify steps w/ STEP=n)
  * **rake db:schema:dump**       - Create a db/schema.rb file that can be portably used against any DB supported by AR
  * **rake db:schema:load**       - Load a schema.rb file into the database
  * **rake db:seed**              - Load the seed data from db/seeds.rb
  * **rake db:setup**             - Create the database, load the schema, and initialize with the seed data (use db:reset to also drop the db first)
  * **rake db:structure:dump**    - Dump the database structure to db/structure.sql
  * **rake db:version**           - Retrieves the current schema version number
