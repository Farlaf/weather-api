# frozen_string_literal: true

require 'grape-swagger'

class RootAPI < Grape::API
  format format_string :json
  prefix :api

  helper do
    def permitted_params
      @permitted_params ||= declared(params, included: false)
    end
  end

  mount ::V1::API

  add_swagger_documentation \
    host: ENV.fetch('SWAGGER_HOST'),
    doc_version: '0.0.1',
    base_path: '/v1/docs',
    add_base_path: true,
    add_version: true,
    info: {
      title: 'Weather API',
      contact_url: 'http://localhost:3000'
    },
    array_use_braces: true
end
