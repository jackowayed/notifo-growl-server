require 'rubygems'
require 'sequel'

task :create_db do
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://notifo.db')

  DB.create_table :notifications do
    primary_key :id
    String :params_hash
  end
end
