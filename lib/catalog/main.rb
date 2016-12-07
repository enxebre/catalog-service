require 'sinatra'
require_relative './stock_client'
require 'prometheus/client'

prometheus = Prometheus::Client.registry
http_requests_suspicious = prometheus.counter(:http_requests_suspicious, 'A counter of HTTP requests')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  set :show_exceptions, :after_handler
end

get '/' do

  if request.env.key?('HTTP_SUSPICIOUS_HEADER')
    http_requests_suspicious.increment({ HTTP_SUSPICIOUS_HEADER: request.env['HTTP_SUSPICIOUS_HEADER'] })
  end	

  @t_shirts = CatalogApp::StockClient.find_all_t_shirts
  erb :home
end

get '/product/t-shirt/:name' do
  @t_shirt = CatalogApp::StockClient.find_t_shirt_by_name params['name']
  erb :t_shirt
end
