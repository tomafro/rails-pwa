require 'rails/pwa/interceptor'

class Rails::PWA::Railtie < ::Rails::Railtie
  config.pwa = ActiveSupport::OrderedOptions.new
  config.pwa.scripts = {
    "/worker.js" => "worker.js"
  }

  initializer "rails-pwa.middleware" do |app|
    scripts = app.config.pwa.scripts
    root    = Rails.env.development? ? false : Rails.public_path

    app.config.middleware.insert_before Rack::Sendfile, Rails::PWA::Interceptor,
      scripts: app.config.pwa.scripts,
      root: root
  end
end
