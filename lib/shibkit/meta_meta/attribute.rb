## @author    Pete Birkinshaw (<pete@digitalidentitylabs.com>)
## Copyright: Copyright (c) 2011 Digital Identity Ltd.
## License:   Apache License, Version 2.0

## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
## 
##     http://www.apache.org/licenses/LICENSE-2.0
## 
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

module Shibkit
  class MetaMeta

    ## Class to represent the metadata of the organisation owning a Shibboleth entity
    class Attribute < MetadataItem

      ## Element and attribute used to select XML for new objects
      ROOT_ELEMENT = 'Attribute'
      TARGET_ATTR  = 'Name'
      REQUIRED_QUACKS = [:Name, :NameFormat]
      
      
      ## 
      attr_accessor :name
      
      attr_accessor :is_required
      
      attr_accessor :name_format
      
      attr_accessor :friendly_name
      
      ## 
      attr_accessor :values
      
      alias :required?     :is_required
      alias :is_required? :is_required
      
      private
     
      ## Nicer presentation as a string
      def to_s
        
        return friendly_name
       
      end
     
     def parse_xml
      
      @name = @noko['Name']
      
      @is_required = @noko['isRequired'].to_s.downcase == 'true' ? true : false
      
      @name_format = @noko['NameFormat']
      
      @friendly_name = @noko['FriendlyName']
      
      @values ||= Array.new
      @noko.xpath('saml:AttributeValue').each { |ax| @values << ax.content.strip }
      
      log.debug "    Derived attribute #{name} from XML"
      
    end
        
    end
  end
end