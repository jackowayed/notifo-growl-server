class Mac
  include HTTPParty
  base_uri 'jackowayed-notifo.oncloud.org'
end



get '/' do
  "working"
end

post '/' do
  # TODO confirm the signature

  app = params[:notifo_service]
  title = params[:notifo_title]
  text = params[:notifo_message]

  Mac.post('/', :query => { :app => app, :title => title, :text => text })
end
