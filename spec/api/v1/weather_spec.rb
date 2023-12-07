require 'rails_helper'

describe ::V1::Weather do
  context 'get current temperature' do
    let(:path) { '/api/v1/weather/current' }

    subject do
      get path
      response
    end

    it 'with success and return json' do
      client = double('test api')

      res = { "WeatherText": 'Sunny',
              "Metric": {
                "Value": 16.5,
                "Unit": 'C',
                "UnitType": 17
              } }
      expect(::AccueWeather::Client).to receive(:new).and_return(client)

      expect(client).to receive_message_chain(:uniq_id, :uniq_id)
        .and_return('123213')

      expect(client).to receive(:current_temperature)
        .and_return(::AccueWeather::APIResponse.new(res))

      is_expected.to be_successful
      expect(response.status).to eq(200)
    end
  end

  context 'get hourly temperature for the last 24h' do
    let(:path) { '/api/v1/weather/historical' }

    subject do
      get path
      response
    end

    it 'with success and return json' do
      client = double('test api')

      res = { body: [
        { 'WeatherText' => 'Sunny',
          'EpochTime' => 1_701_954_120,
          'Temperature' => {
            'Metric' => {
              "Value": 16.5,
              "Unit": 'C',
              "UnitType": 17
            }
          } }
      ] }
      expect(::AccueWeather::Client).to receive(:new).and_return(client)

      expect(client).to receive_message_chain(:uniq_id, :uniq_id)
        .and_return('123213')

      expect(client).to receive(:historical_temperature)
        .and_return(::AccueWeather::APIResponse.new(res))

      is_expected.to be_successful
      expect(response.status).to eq(200)
    end
  end

  context 'get max temperature for the last 24h' do
    let(:path) { '/api/v1/weather/historical/max' }

    subject do
      get path
      response
    end

    it 'with success and return json' do
      client = double('test api')

      res = { body: [
        { 'WeatherText' => 'Sunny',
          'EpochTime' => 1_701_954_120,
          'Temperature' => {
            'Metric' => {
              "Value": 16.5,
              "Unit": 'C',
              "UnitType": 17
            }
          } }
      ] }
      expect(::AccueWeather::Client).to receive(:new).and_return(client)

      expect(client).to receive_message_chain(:uniq_id, :uniq_id)
        .and_return('123213')

      expect(client).to receive(:historical_temperature)
        .and_return(::AccueWeather::APIResponse.new(res))

      is_expected.to be_successful
      expect(response.status).to eq(200)
    end
  end

  context 'get min temperature for the last 24h' do
    let(:path) { '/api/v1/weather/historical/min' }

    subject do
      get path
      response
    end

    it 'with success and return json' do
      client = double('test api')

      res = { body: [
        { 'WeatherText' => 'Sunny',
          'EpochTime' => 1_701_954_120,
          'Temperature' => {
            'Metric' => {
              "Value": 16.5,
              "Unit": 'C',
              "UnitType": 17
            }
          } }
      ] }
      expect(::AccueWeather::Client).to receive(:new).and_return(client)

      expect(client).to receive_message_chain(:uniq_id, :uniq_id)
        .and_return('123213')

      expect(client).to receive(:historical_temperature)
        .and_return(::AccueWeather::APIResponse.new(res))

      is_expected.to be_successful
      expect(response.status).to eq(200)
    end
  end

  context 'get avg temperature for the last 24h' do
    let(:path) { '/api/v1/weather/historical/avg' }

    subject do
      get path
      response
    end

    it 'with success and return json' do
      client = double('test api')

      res = { body: [
        { 'WeatherText' => 'Sunny',
          'EpochTime' => 1_701_954_120,
          'Temperature' => {
            'Metric' => {
              'Value' => 16.5,
              'Unit' => 'C',
              'UnitType' => 17
            }
          } }
      ] }
      expect(::AccueWeather::Client).to receive(:new).and_return(client)

      expect(client).to receive_message_chain(:uniq_id, :uniq_id)
        .and_return('123213')

      expect(client).to receive(:historical_temperature)
        .and_return(::AccueWeather::APIResponse.new(res))

      is_expected.to be_successful
      expect(response.status).to eq(200)
    end
  end
end
