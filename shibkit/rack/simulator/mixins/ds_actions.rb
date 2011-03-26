module Shibkit
  module Rack
    class Simulator
      module Mixin
        module DSActions
          

          ####################################################################
          ## WAYF Actions
          ##
          
          ## Controller for 
          def wayf_action(env, wayf_session, options={})
            
            ds_session = Shibkit::Rack::Simulator::Model::WAYFSession.new(env)            

            ## If passed all required info (the IDP URI has been supplied) then...
            if ds_session.origin then
          
              return ds_session.wayf_request? ?
                wayf_forward_to_idp_response(ds_session) :
                  ds_forward_to_idp_response(ds_session)
          
            end
            
            ## Otherwise display some info to help users choose
            case ds_session.request_type
            when :ds, :wayf
              return ds_wayf_response(ds_session)
            when :ui
              return ds_origin_lookup_response(ds_session)
            else
              #return ds_direct_response(ds_session)
              return ds_wayf_response(ds_session)
            end
              
          end
          
          ## Build standard page
          def ds_wayf_response(ds_session)
          
            code = 200
            
            locals = get_locals(
              :layout     => :layout,
              :javascript => :wayf,
              :wayf       => ds_session, 
              :idps       => ds_session.ds_service.idps.sort! { |a,b| a.display_name.downcase <=> b.display_name.downcase },
              :page_title => "Select Your Home Organisation"
            )
            
            page_body = render_page(:wayf_smart, locals)
              
            return code, Shibkit::Rack::HEADERS, [page_body.to_s]
          
          
          end
          
          ## Build an AJAX JSON reply
          def ds_origin_lookup_response(ds_session)
            
            results = Array.new
            
            ## We've got a term request so respond with JSON
            unless ds_session.term.empty?  
              
              ds_session.ds_service.idps.each do |idp|
              
                if idp.display_name.downcase =~ /#{term}/  
              
                  result = Hash.new
                  result['id']    = idp.id
                  result['label'] = idp.display_name
                  result['value'] = idp.display_name
                 
                  results << result
                  
                end
              
              end
              
              page_body = results.to_json

              return code,
                { "Content-Type" => "application/json" },
                page_body
              
            end

          end
          
          ## Build
          
        end
      end
    end
  end
end