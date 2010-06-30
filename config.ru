require 'rubygems'
require 'sinatra'

set :env,       :production
set :port,      4567
disable :run, :reload

require 'notifo-growl-server'

run Sinatra::Application
