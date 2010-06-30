require 'net/http'
require 'uri'
require 'sequel'
require 'timeout'
require 'yaml'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://notifo.db')

get '/' do
  "working"
end

post '/' do
  send_notification params
  "ok"
end

post '/flush' do
  notifications = DB[:notifications]

  id = notifications.last.id
  notifications.each do |n|
    send_notification YAML::load(n)
  end

  DB[:notifications].filter('id <= ?', id).delete
  "ok"
end


def send_notification(hash)
  begin
    Timeout::timeout(5) do
      Net::HTTP.post_form(URI.parse('http://jackowayed-notifo.oncloud.org/'), hash)
    end
  rescue Timeout::Error
    DB[:notifications].insert(:params_hash => YAML::dump(params))
  end
end
