module V1
  class Backend < Grape::API
    resource :health do
      desc 'Get status of backend health'
      get '/' do
        result = { status: 200 }

        present result
      end
    end
  end
end