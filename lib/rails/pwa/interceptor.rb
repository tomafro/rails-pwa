module Rails
  module PWA
    class Interceptor
      attr_reader :app, :server, :scripts

      def initialize(app, scripts:, root: false, **options)
        @app     = app
        @scripts = scripts.dup

        if root
          @server = ::Rack::File.new(root)
        else
          @server = app
        end
      end

      def call(env)
        if pack = scripts[env["PATH_INFO"]]
          respond_with_pack(env, pack)
        else
          app.call(env)
        end
      end

      def respond_with_pack(env, pack)
        path_info = env["PATH_INFO"]
        env["PATH_INFO"] = Webpacker.manifest.lookup!(pack)

        server.call(env)
      ensure
        env["PATH_INFO"] = path_info
      end
    end
  end
end
