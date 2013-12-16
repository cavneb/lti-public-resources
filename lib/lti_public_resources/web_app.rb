require 'rack'
require 'pry'

module LtiPublicResources
  class WebApp

    def initialize(app, config_file)
      @app = Rack::Builder.new do
        map '/' do
          root = File.join(BASE_PATH, 'ember-app', 'dist')
          use Rack::Static,
            :urls => Dir.glob("#{root}/*").map { |fn| fn.gsub(/#{root}/, '')},
            :root => root

          run lambda { |env|
            [ 200, { 'Content-Type' => 'text/html', 'Cache-Control' => 'public, max-age=86400' }, 
              File.open("#{root}/index.html", File::RDONLY) ]
          }
        end

        map '/api' do
          run ApiApp.new(nil, config_file)
        end
      end
    end

    def call(env)
      req = Rack::Request.new(env)
      launch_params = req.params

      status, headers, response = @app.call(env)

      response_body = ""
      response.each { |part| response_body += part }

      env_data = {}
      env_data['CONFIG'] = { host: '' }
      env_data['TOOL_ID'] = launch_params['tool_id'] || ''
      env_data['LAUNCH_PARAMS'] = launch_params

      script = "<script>window.ENV = #{env_data.to_json};</script>"
      mod_response_body = response_body.gsub('DIST_ENV', script)

      [status, headers, [mod_response_body]]
    end

  end
end