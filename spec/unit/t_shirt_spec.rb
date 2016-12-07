require_relative '../spec_helper'
require 'catalog/models/t_shirt'

module CatalogApp
  module Products
    describe "TShirt" do
      describe '.initialize' do
        context 'When passing a name' do
          it 'Sets the class variable' do
            attributes = { :name => 'testName'}
            t_shirt = TShirt.new attributes
            expect(t_shirt.name).to eq('testName')
          end
        end
      end
    end
  end
end