require 'httparty'
require_relative 'models/t_shirt'
require 'benchmark'
require 'prometheus/client'

module CatalogApp
  class StockClient
    
    include HTTParty
    base_uri 'http://stock'

    prometheus = Prometheus::Client.registry
    @remote_calls_summary = Prometheus::Client::Summary.new(:remote_calls_summary, 'A histogram of the response latency for remote calls')
    prometheus.register(@remote_calls_summary)

    def self.find_all_t_shirts

      @remote_calls_summary.observe({ service_call: 'find_all_t_shirts' }, Benchmark.realtime { 
        response = get("/t-shirt", :headers => {'Accept' => 'application/json'})
        @t_shirt_list = []
        when_successful(response) do
          body = parse_body(response)
          body.each do |t_shirt|
            @t_shirt_list.push(CatalogApp::Products::TShirt.new(t_shirt))
          end
        end
      })
      return @t_shirt_list
    end

    def self.find_t_shirt_by_name name
      response = get("/t-shirt/#{name}", :headers => {'Accept' => 'application/json'})
      when_successful(response) do
        CatalogApp::Products::TShirt.new(parse_body(response))
      end
    end

    def self.when_successful response
      if response.success?
        yield
      elsif response.code == 404
        nil
      else
        raise response.body
      end
    end

    def self.parse_body response
      JSON.parse(response.body, {:symbolize_names => true})
    end

  end
end