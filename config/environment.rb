require 'bundler'
Bundler.require
require 'require_all'


ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
# ENV['SINATRA_ACTIVESUPPORT_WARNING']=false


require_all 'app'
require_all 'lib'
