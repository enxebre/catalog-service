require 'rspec/core/rake_task'
require 'pact_broker/client/tasks'

$: << './lib'

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:consumer_driven_contracts) do |t|
  t.pattern = 'spec/**{,/*/**}/service_providers/*_spec.rb'
end

RSpec::Core::RakeTask.new(:unit) do |t|
  t.pattern = 'spec/**{,/*/**}/unit/*_spec.rb'
end

PactBroker::Client::PublicationTask.new do | task |
  require 'catalog/version'
  task.consumer_version = CatalogApp::VERSION
  task.pact_broker_base_url = "http://pact-broker-pact-broker.tooling.178.62.64.127.nip.io"
end

task :default => :spec