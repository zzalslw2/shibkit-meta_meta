##
##

require 'uuid'
require 'haml'
require 'yaml'
require 'time'
require 'rack/logger'

## Require various mixins too
require 'shibkit/rack/simulator/mixins/render'
require 'shibkit/rack/simulator/mixins/actions'
require 'shibkit/rack/simulator/mixins/injection'
require 'shibkit/rack/simulator/mixins/logging'

## Default record filter mixin code
require 'shibkit/rack/simulator/record_filter'

module Shibkit
  
  module Rack
  
    class Simulator
      
      ## Methods have been split up into mixins to make things more manageable
      include Shibkit::Rack::Simulator::Mixin::Injection
      include Shibkit::Rack::Simulator::Mixin::Render
      include Shibkit::Rack::Simulator::Mixin::Actions
      include Shibkit::Rack::Simulator::Mixin::Logging
      
      ## Easy access to Shibkit's configuration settings
      include Shibkit::Configured
    
      ## Middleware application components and behaviour
      CONTENT_TYPE   = { "Content-Type" => "text/html; charset=utf-8" }
      VIEWS          = [:user_chooser, :fatal_error, :session_status]
  
      def initialize(app)
      
        ## Rack app
        @app = app
  
      end
  
      ## Selecting an action and returning to the Rack stack 
      def call(env)
      
        ## Peek at user input, they might be talking to us
        request = ::Rack::Request.new(env)
        
        ## Models used to adjust session states
        idp  = Shibkit::Rack::Simulator::Model::IDPSession.new(env)
        sp   = Shibkit::Rack::Simulator::Model::SPSession.new(env)
        wayf = Shibkit::Rack::Simulator::Model::WAYFSession.new(env)
        dir  = Shibkit::Rack::Simulator::Model::IDP_Session.new(env)
        
        models = {:idp => idp, :sp => sp, :wayf => wayf, :dir => dir}
        
        ## Catching exceptions in the workflow/routing
        begin

          ## Route to actions according to requested URLs
          case request.path
          
          ## IDP status information
          when idp.status_path
            
            return idp_status_action(env, models)
            
          ## IDP session information
          when idp.session_path
            
            return idp_session_action(env, models) 
          
          ## Request is for the fake IDP's login function
          when idp.login_path
          
            ## Specified a user? (GET or POST) then try logging in
            if request.params['user'] 
              
              return idp_login_action(env, models)
            
            ## Already logged in? With SSO log in again.
            elsif idp.sso? and idp.logged_in?
              
              return idp_sso_action(env, models)
            
            ## Show the chooser page to present login options  
            else
            
              return idp_simple_chooser_action(env, models)
              
          ## IDP SLO request?     
          when idp.logout_path
              
            return idp_logout_action(env, models)
            
          ## WAYF request?
          when wayf.path
              
            return wayf_action(env, models)  
            
          ## SP session status page?
          when sp.session_path
              
            return sp_session_status_action(env, models)
          
          ## SP protected page?    
          when sp.masked_path
            
            ## Valid session in SP
            if sp.logged_in?
              
              return sp_protected_page_action(env, models)
              
            else
              
              return sp_login_action(env, models)
              
            end
            
          else
            
            ## Do nothing, pass on up to the application
            return @app.call(env, models)
            
        end

        ## Catch any errors generated by this middleware class. Do not catch other Middleware errors.
        rescue Rack::Simulator::RuntimeError => oops
        
          ## Render a halt page
          return fatal_error_action(env, oops)
    
        end

      end
  
      private
  
      # ...
  
    end

  end
end

 
            
 =================================
              
               ## Where do we send users to after they authenticate with IDP?
                destination = request.params['destination'] || '/'
              
              log_debug("(IDP) New user authentication requested")
              
                      
                        
              
              ## Get our user information using the param
              user_details = users[user_id.to_s]
            
              ## Check user info is acceptable
              unless user_details_ok?(user_details)
              
                log_debug("(IDP) User authentication failed - requested user not found")
              
                ## User was requested but no user details were found
                message = "User with ID '#{user_id}' could not be found!"
                http_status_code = 401
              
                return user_chooser_action(env, { :message => message, :code => code })
              
              end
            
              ## 'Authenticate', create sim IDP/SP session
              set_session(env, user_details)

              ## Clean up
              tidy_request(env)

              log_debug("(IDP) User authentication succeeded.")
 
              ## Redirect back to original URL
              return [ 302, {'Location'=> destination }, [] ]

            else
              
              ## Has not specified a user. So, already got a shibshim session? (shared by fake IDP and fake SP)
              if existing_idp_session?(env) and @sso

                log_debug("(IDP) User already authenticated. Redirecting back to application")

                return [ 302, {'Location'=> destination }, [] ]

              end
              
              ## Not specified a user and not got an existing session, so ask user to 'authenticate'
              log_debug("(IDP) Not already authenticated. Storing destination and showing Chooser page.")

              ## Tidy up
              tidy_request(env)
            
              ## Show the chooser page    
              return user_chooser_action(env)
         
            end
        
          ## Request is for the fake IDP's logout URL
          when sim_idp_logout_path
          
            ## Kill session
            reset_sessions(env) 
          
            log_debug("(IDP) Reset session, redirecting to IDP login page")
          
            ## Redirect to IDP login (or wayf)
            return [ 302, {'Location'=> sim_idp_login_path }, [] ]
        
          ## Request is for the fake WAYF
          when sim_wayf_path
          
            ## Specified an IDP?

          
            ## Redirect to IDP with Org type in session or something

            
            ## Not specified an IDP

          
            ## Show WAYF page

        
          ## Gateway URL? Could cover whole application or just part
          when sim_sp_path_regex 

            ## Has user already authenticated with the SP? If so we can simulate SP header injection
            if existing_sp_session? env
              
              ## TODO: SP sessions should expire
              
              log_debug("(SP)  Already authenticated with IDP and SP so injecting headers and calling application")
            
              ## Get our user information using the param
              sp_user_id = sim_sp_session(env)[:user_id]
              user_details = users[sp_user_id.to_s]
            
              ## Inject headers
              inject_sp_headers(env, user_details)
            
              ## Pass control up to higher Rack middleware and application
              return @app.call(env)
            
            end
            
            ## If the user has IDP session but not SP, we need to authenticate them at SP # TODO: possibly make this DRYer, or leave clearer?
            if existing_idp_session? env
              
              ## TODO: IDP sessions should expire
              
              log_debug("(SP)  Already authenticated with IDP but not SP, so authenticating with SP now.")
            
              ## Mark this user as authenticated with SP, so we can detect changed users, etc
              idp_user_id = sim_idp_session(env)[:user_id]
              sp_user_id = idp_user_id
              sim_sp_session(env)[:user_id] = sp_user_id
              
              ## Get user details
              user_details = users[sp_user_id.to_s]
              
              ## Inject headers
              inject_sp_headers(env, user_details)
              
              ## Pass control up to higher Rack middleware and application
              return @app.call(env)
              
            end
            
            ## If the user has neither an SP session or IDP session then they need one!
            log_debug("(SP)  No suitable IDP/SP sessions found, so redirecting to IDP to authenticate")
            
            ## Tidy up session to make sure we start from nothing (may have inconsistent, mismatched SP & IDP user ids)
            reset_sessions(env)
            
            ## Store original destination URL
            destination = ::Rack::Utils.escape(request.url)

            ## Redirect to fake IDP URL (or wayf, later)
            return [ 302, {'Location'=> "#{sim_idp_login_path}?destination=#{destination}" }, [] ]

          when sim_sp_session_path
            
            log_debug("(SP) Showing SP session status page")
          
            return sp_session_action(env, stats)
            
          ## If not a special or authenticated URL
          else
         
           ## Behave differently if in gateway mode? TODO
           log_debug("(SP)  URL not behind the SP, so just calling application")
         
           ## Pass control up to higher Rack middleware and application
           return @app.call(env)
         
          end


