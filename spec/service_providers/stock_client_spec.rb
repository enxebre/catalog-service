require_relative 'pact_helper'
require 'catalog/stock_client'

module CatalogApp
  describe StockClient, :pact => true do

    before do
      # Configure your client to point to the stub service on localhost using the port you have specified
      StockClient.base_uri stock.mock_service_base_url
    end

    describe "find_all_t_shirts" do
      context "when the t-shirt stock is not empty" do
        before do
          # Set up mock behaviour
          stock.given("the t-shirt stock is not empty").
            upon_receiving("a request for all the t-shirt").
            with(method: :get, path: '/t-shirt', query: '').
            will_respond_with(
              status: 200,
              headers: {'Content-Type' => 'application/json'},
              body: [{'name' => 'surfer-t-shirt'}, {'name' => 'formal-t-shirt'}] )
        end

        it "returns a list of t-shirts" do
          expect(StockClient.find_all_t_shirts()[0].name).to eq('surfer-t-shirt')
          expect(StockClient.find_all_t_shirts()[1].name).to eq('formal-t-shirt')
          expect(StockClient.find_all_t_shirts().length).to eq(2)
        end
      end
    end

    describe "find_t_shirt_by_name" do

      context "when a t-shirt by the given name exists" do
        before do
          # Set up mock behaviour
          stock.given("a t-shirt exists").
            upon_receiving("a request for a t-shirt").
            with(method: :get, path: '/t-shirt/surfer-t-shirt', query: '').
            will_respond_with(
              status: 200,
              headers: {'Content-Type' => 'application/json'},
              body: {name: 'surfer-t-shirt'} )
        end

        it "returns a t-shirt" do
          expect(StockClient.find_t_shirt_by_name 'surfer-t-shirt').to eq(CatalogApp::Products::TShirt.new({:name => 'surfer-t-shirt'}))
          expect((StockClient.find_t_shirt_by_name 'surfer-t-shirt').name).to eq('surfer-t-shirt')
        end
      end

      context "when a t-shirt by the given name does not exist" do

        before do
          stock.given("there is not a t-shirt with name surfer-t-shirt").
            upon_receiving("a request for a t-shirt").with(
              method: :get,
              path: '/t-shirt/surfer-t-shirt',
              headers: {'Accept' => 'application/json'} ).
            will_respond_with(status: 404)
        end

        it "returns nil" do
          expect(StockClient.find_t_shirt_by_name 'surfer-t-shirt').to be_nil
        end

      end

      context "when an error occurs retrieving the t-shirt" do

        before do
          stock.given("an error occurs retrieving a t-shirt").
            upon_receiving("a request for an t-shirt").with(
              method: :get,
              path: '/t-shirt/surfer-t-shirt',
              headers: {'Accept' => 'application/json'}).
            will_respond_with(
              status: 500,
              headers: { 'Content-Type' => 'application/json'},
              body: {error: 'Argh!!!'})
        end

        it "raises an error" do
          expect{ StockClient.find_t_shirt_by_name 'surfer-t-shirt' }.to raise_error /Argh/
        end

      end

    end
  end
end