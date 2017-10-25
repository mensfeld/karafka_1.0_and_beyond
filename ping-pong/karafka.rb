# frozen_string_literal: true

# Non Ruby on Rails setup
ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']
Bundler.require(:default, ENV['KARAFKA_ENV'])
Karafka::Loader.load(Karafka::App.root)

class App < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = ::Settings.kafka.seed_brokers
    config.kafka.offset_commit_threshold = 30
    config.client_id = ::Settings.name
    config.backend = :inline
    config.batch_processing = true
  end

  consumer_groups.draw do
    topic :users_events do
      controller UsersEventsController
      responder UsersEventsResponder
    end

    topic :users_engaged do
      controller UsersEngagedController
    end
  end
end

App.boot!
