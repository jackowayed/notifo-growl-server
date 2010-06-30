require 'net/http'
require 'uri'
require 'sequel'
require 'timeout'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://notifo.db')

get '/' do
  "working"
end

post '/' do
  send_notification params
end

post '/flush' do
  notifications = DB[:notifications]

  id = notifications.last.id
  notifications.each do |n|
    send_notification Marshal.load(n)
  end

  DB[:notifications].filter('id <= ?', id).delete
end


def send_notification(hash)
  begin
    Timeout::timeout(5) do
      Net::HTTP.post_form(URI.parse('http://jackowayed-notifo.oncloud.org/'), hash)
    end
  rescue Timeout::Error
    DB[:notifications].insert(:params_hash => Marshal.dump(params))
  end
end
