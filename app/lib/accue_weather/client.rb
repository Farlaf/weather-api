# frozen_string_literal: true

module AccueWeather
  class Client
    Error = Class.new(StandardError)

    ACCUE_WEATHER_URL = 'dataservice.accuweather.com'

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def uniq_id(city:)
      api_request(
        url_with_path('/locations/v1/cities/search'),
        ::AccueWeather::APIRequestFactory
          .new
          .uniq_id(city)
          .to_query
      )
    end

    private

    def api_request(url, params = {})
      response = http_get(url, params)

      ::AccueWeather::APIResponse.new(response)
    end

    def http_get(url, params)
      http_request do
        HTTParty.get("#{url}?#{params}", request_params)
      end
    end

    def http_request(&block)
      response = handle_request_exception(&block)

      handle_response(response)
    end

    def request_params
      {
        headers: {
          'Accept-Encoding': 'gzip',
          'Accept-Language': 'en-US',
          'Host': ACCUE_WEATHER_URL
        }
      }
    end

    def handle_request_exception
      yield
    rescue ::OpenSSL::SSL::AllocationError
      raise_error 'AccueWeather returned invalid SSL data'
    rescue ::Net::OpenTimeout
      raise_error 'AccueWeather connection time out'
    rescue StandardError => e
      raise_error "AccueWeather request fails due to #{e.class}"
    end

    def raise_error(message)
      raise Client::Error, message
    end

    def handle_response(response)
      return { body: response.parsed_response, headers: response.headers } if response.code < 400

      raise_error "AccueWeather response status code: #{response.code}, Message: #{response.body}"
    end

    def url_with_path(new_path)
      new_url = accue_weather_uri.dup
      new_url.path += [new_path].join('/').squeeze('/')
      new_url.to_s
    end

    def accue_weather_uri
      @accue_weather_uri ||= URI("https://#{ACCUE_WEATHER_URL}").freeze
    end
  end
end
