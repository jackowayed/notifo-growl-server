require 'httparty'

class Mac
  include HTTParty
  base_uri 'jackowayed-notifo.oncloud.org'
end



get '/' do
  "working"
end

post '/' do
  # TODO confirm the signature

  Mac.post('/', :query => params)
end
