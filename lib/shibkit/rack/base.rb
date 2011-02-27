##
##





module Shibkit
  
  module Rack
  
    class Base
        
      require 'uuid'
      require 'haml'
      require 'yaml'
      require 'time'
      require 'uri'
      require 'rack/logger'
      require 'json'
      
      ## Require various mixins too
      require 'shibkit/rack/base/mixins/render'
      require 'shibkit/rack/base/mixins/actions'
      require 'shibkit/rack/base/mixins/logging'
      require 'shibkit/rack/base/mixins/http_utils'
      require 'shibkit/rack/exceptions'
      
      
      ## Methods have been split up into mixins to make things more manageable
      include Shibkit::Rack::Base::Mixin::Render
      include Shibkit::Rack::Base::Mixin::Actions
      include Shibkit::Rack::Base::Mixin::Logging
      include Shibkit::Rack::Base::Mixin::HTTPUtils
       
      ## Easy access to Shibkit's configuration settings
      include Shibkit::Configured
    
      ## Middleware application components and behaviour
      CONTENT_TYPE   = { "Content-Type" => "text/html; charset=utf-8" }
      START_TIME     = Time.new
    
      def initialize(app)
      
        ## Rack app
        @app = app
        
         log_debug("Initializing")
        
      end
      
      ## Selecting an action and returning to the Rack stack 
      def call(env)
      
        ## Onwards and upwards: pass control through to next middleware in rack
        return @app.call(env)

      end
      
      private
      
      ## Reformat the base path for IDP URLs to capture info in URL
      def base_path_regex(base_path)

        normalised_path = base_path.gsub(/\/$/, '')
        return Regexp.new(normalised_path)

      end
      
      ## 
      ## Memoise relatively expensive regex creation and escaping
      def regexify(path)
        
        @recache ||= Hash.new
        
        unless @recache[path]
          
          @recache[path] ||= /#{Regexp.escape(path)}/
        
        end
        
        return @recache[path]
        
      end
  
      def component_name
        
        return self.class.to_s.gsub('::', ':').split(':').reverse[0].downcase
        
      end
  
    end

  end
end



