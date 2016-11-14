if RUBY_ENGINE == 'jruby'
  require 'activerecord-jdbcmysql-adapter'
else
  require 'mysql2'
end
require 'active_record'
require 'carrierwave/orm/activerecord'

# Change this if MySQL is unavailable
dbconfig = {
  :adapter  => 'mysql2',
  :database => 'carrierwave_test',
  :username => 'root',
  :password => 'rootpass',
  :encoding => 'utf8'
}

database = dbconfig.delete(:database)

ActiveRecord::Base.establish_connection(dbconfig)
begin
  ActiveRecord::Base.connection.create_database database
rescue ActiveRecord::StatementInvalid => e # database already exists
end
ActiveRecord::Base.establish_connection(dbconfig.merge(:database => database))

ActiveRecord::Migration.verbose = false
