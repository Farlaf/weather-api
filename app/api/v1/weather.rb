# frozen_string_literal: true

# Top level module
module V1
  # Weather API
  class Weather < Grape::API
    CITY = 'batumi'

    before do
      def client
        @client ||= ::AccueWeather::Client.new('weather api')
      end

      def uniq_id
        @uniq_id ||= client.uniq_id(city: CITY).uniq_id
      end
    end

    resource :weather do
      desc 'get current temperature'
      get '/current' do
        result = client.current_temperature(uniq_id:)

        present city: CITY, text: result.weather_text, temperature: result.temperature
      end

      namespace :historical do
        desc 'hourly temperature for the last 24h'
        get '/' do
          result = client.historical_temperature(uniq_id:)

          present result.temperature_24_h
        end
      end
    end



  end
end
