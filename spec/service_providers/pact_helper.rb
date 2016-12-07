require_relative '../spec_helper'
require 'pact/consumer/rspec'

Pact.configure do | config |
  config.doc_generator = :markdown
end

Pact.service_consumer "Catalog App" do
  has_pact_with "Stock Service" do
    mock_service :stock do
      port 1234
    end
  end
end