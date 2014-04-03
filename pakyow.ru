require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :pakyow)

require 'pakyow'

class Wiggles < Pakyow::App
  configure :development do
    server.port = '9292'
    app.src_dir = './'
    app.auto_reload = false
    app.errors_in_browser = false
  end

  routes do
    restful :wiggle, '/wiggles' do
      list do
        Wiggle.all.to_json
      end

      get '/wiggles/:id' do
        Wiggle.find(params[:id]).to_json
      end

      get '/wiggles/:id/comments' do
        Wiggle.find(params[:id]).comments.to_json
      end
    end
  end
end

app = Pakyow::App
use ActiveRecord::ConnectionAdapters::ConnectionManagement
app.builder.run(app.stage(ENV['RACK_ENV']))
run app.builder.to_app
