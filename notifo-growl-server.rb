require 'net/http'
require 'uri'

get '/' do
  "working"
end

post '/' do
  # TODO confirm the signature

  Net::HTTP.post_form(URI.parse('http://jackowayed-notifo.oncloud.org/'), params)
end
