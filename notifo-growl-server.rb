require 'net/http'
require 'uri'
require 'sequel'

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
    Net::HTTP.post_form(URI.parse('http://jackowayed-notifo.oncloud.org/'), hash)
  rescue
    DB[:notifications].insert(:params_hash => Marshal.dump(params))
  end
end
