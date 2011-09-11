require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Shibkit::MetaMeta do
  
  describe "#reset" do
    it "should reduce the number of sources to zero" do
      Shibkit::MetaMeta.reset
      Shibkit::MetaMeta.additional_sources.size.should == 0 &&
      Shibkit::MetaMeta.loaded_sources.size.should == 0 
    end
  end

  describe "#add_source" do

    it "should accept a single source" do
      Shibkit::MetaMeta.reset
      Shibkit::MetaMeta.add_source({
          :uri           => 'http://ukfederation.org.uk',
          :name          => 'UK Access Management Federation For Education And Research',
          :display_name  => 'UK Access Management Federation',
          :type          => 'federation',
          :countries     => ['gb'],
          :metadata      => 'http://metadata.ukfederation.org.uk/ukfederation-metadata.xml',
          :certificate   => 'http://metadata.ukfederation.org.uk/ukfederation.pem',
          :fingerprint   => '94:7F:5E:8C:4E:F5:E1:69:E7:DF:68:1E:48:AA:98:44:A5:41:56:EE',
          :refeds_info   => 'https://refeds.terena.org/index.php/FederationUkfed',
          :homepage      => 'http://www.ukfederation.org.uk',
          :languages     => ['en-gb', 'en'],
          :support_email => ' service@ukfederation.org.uk',
          :description   => 'A single solution for accessing online resources and services',
      })
      Shibkit::MetaMeta.additional_sources.size.should == 1 &&
      Shibkit::MetaMeta.additional_sources.first[0].should == 'http://ukfederation.org.uk'
    end

    it "should accept more than one source" do
      Shibkit::MetaMeta.add_source({
          :uri           => 'urn:mace:aaf.edu.au:AAFProduction',
          :name          => 'Australian Access Federation',
          :display_name  => 'AAF',
          :type          => 'federation',
          :countries     => ['au'],
          :metadata      => 'http://manager.aaf.edu.au/metadata/metadata.aaf.signed.complete.xml',
          :certificate   => 'https://manager.aaf.edu.au/metadata/metadata-cert.pem',
          :refeds_info   => 'https://refeds.terena.org/index.php/FederationAAF',
          :homepage      => 'http://www.aaf.edu.au/',
          :languages     => ['en'],
          :support_email => 'enquiries@aaf.edu.au',
          :description   => 'The Australian Access Federation.',
      })
      Shibkit::MetaMeta.additional_sources.size.should == 2 &&
      Shibkit::MetaMeta.additional_sources.keys[1].should == 'http://ukfederation.org.uk' &&
      Shibkit::MetaMeta.additional_sources.keys[0].should == 'urn:mace:aaf.edu.au:AAFProduction'
    end

  end

  describe "#save_sources" do
    it "should save the sources list to a file" do
      tmpfile = Tempfile.new('metametasources')
      @@sourcesfile = tmpfile.path
      tmpfile.close
      Shibkit::MetaMeta.save_sources(@@sourcesfile)
      (File.exists? @@sourcesfile).should == true &&
      File.size(@@sourcesfile).should > 0 
    end
  end
  describe "#load_sources" do
    it "should automatically load sources if no source file has been specified." do
      Shibkit::MetaMeta.load_sources
      Shibkit::MetaMeta.loaded_sources.size.should == 4 &&
      Shibkit::MetaMeta.loaded_sources.keys[2].should == 'http://ukfederation.org.uk'
    end
    it "should be possible to set the file to load from" do
      Shibkit::MetaMeta.reset
      Shibkit::MetaMeta.config.sources_file=@@sourcesfile
    end
    it "should load sources from a file" do
      Shibkit::MetaMeta.load_sources
      Shibkit::MetaMeta.loaded_sources.size.should == 2 &&
      Shibkit::MetaMeta.loaded_sources.keys[1].should == 'http://ukfederation.org.uk' &&
      Shibkit::MetaMeta.loaded_sources.keys[0].should == 'urn:mace:aaf.edu.au:AAFProduction'
    end
  end

  describe "#load_cache_file" do
    
    it "should"
    
  end
  
  describe "#save_cache_file" do
    
    it "should"
    
  end
  
end
