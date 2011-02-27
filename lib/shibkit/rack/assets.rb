##
##

module Shibkit
  
  module Rack
  
    class Assets < Shibkit::Rack::Base
      
      ## Middleware application components and behaviour
      CONTENT_TYPE   = { "Content-Type" => "text/html; charset=utf-8" }
      START_TIME     = Time.new
      
      ## Selecting an action and returning to the Rack stack 
      def call(env)
      
        ## Peek at user input, they might be talking to us
        request = ::Rack::Request.new(env)
 
        ## Catching top-level exceptional exceptions in the workflow/routing
        ## (404s etc will be handled inside this, hopefully)
        begin

          #log_debug(request.path)

          ## Route to actions according to requested URLs
          case request.path
          
          ####################################################################
          ## Asset Routing
          ##
          
          ## Return the global stylesheet
          when regexify(stylesheet_path)

            return stylesheet_action(env, nil, {})

          ## Return a Javascript file
          when regexify(script_path)

            matches = request.path.match /\/scripts\/(\w+)(\.*.*)/
            specified = matches[1]

            return specified ?
              javascript_action(env, nil, {:specified => specified}) :
              simple_404_action(env, nil, {})

          ## Return image file
          when regexify(image_path)

            matches = request.path.match /\/images\/(\w+)(\.*.*)/
            specified = matches[1]

            return specified ?
              image_action(env, nil, {:specified => specified}) :                         
              simple_404_action(env, nil, {})
          
                   
          else

            ## Pass control to application (or next Rack middleware)
            return @app.call(env)
            
        end

        ## Catch any errors generated by this middleware class. Do not catch other Middleware errors.
        rescue Shibkit::Rack::RuntimeError => oops
        
          ## Render a halt page
          return fatal_error_action(env, oops)
    
        end

      end
      
      private
      
      ##
      ## Work out where the scripts should be in (path for URL)
      def script_path
        
        glue_paths(config.sim_asset_base_path, 'scripts')
        
      end
      
      ##
      ## and where the images are going to be 
      def image_path 
      
        glue_paths(config.sim_asset_base_path, 'images')
    
      end
      
      ##
      ## and finally where the stylesheet is (there's just the one)
      def stylesheet_path
        
        return glue_paths(config.sim_asset_base_path, 'stylesheet.css')
      
      end
      
    end

  end
end



