module AccueWeather
  class APIResponse
    include ApplicationHelper

    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def uniq_id
      @uniq_id ||= get_nested_value(response, 'Key')
    end

    def weather_text
      @weather_text ||= get_nested_value(response, 'WeatherText')
    end

    def temperature
      @temperature ||= get_nested_value(response, 'Metric')
    end

    def temperature_24_h
      hash = {}
      response[:body].each do |value|
        key = Time.at(value['EpochTime']).to_datetime
        hash[key] = value['Temperature']['Metric'] if hash[key].blank?
        hash[key].merge(weather_text:)
      end

      hash
    end

    def max_temperature_24_h
      temperature_24_h.values.map { |t| t['Value'] }.max
    end

    def min_temperature_24_h
      temperature_24_h.values.map { |t| t['Value'] }.min
    end

    def avg_temperature_24_h
      array = []
      temperature_24_h.each_value do |item|
        array << item['Value']
      end

      (array.instance_eval { reduce(:+) / size.to_f }).round(2)
    end

  end
end
