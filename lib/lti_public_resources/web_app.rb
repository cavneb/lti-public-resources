require 'rack'

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
            [ 200, { 'Content-Type'  => 'text/html',  'Cache-Control' => 'public, max-age=86400' },
              File.open("#{root}/index.html", File::RDONLY) ]
          }
        end

        map '/api' do
          run ApiApp.new(nil, config_file)
        end
      end
    end

    def call(env)
      @app.call(env)
    end

  end
end