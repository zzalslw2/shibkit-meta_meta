# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shibkit-meta_meta}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Pete Birkinshaw}]
  s.date = %q{2011-11-07}
  s.description = %q{Utilities for friendly handling of Shibboleth/SAML2 metadata. Easily download and parse metadata XML into Ruby objects.}
  s.email = %q{gems@digitalidentitylabs.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "Icon.png",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "examples/biggest_entity_id.rb",
    "lib/scratch_test.rb",
    "lib/shibkit/meta_meta.rb",
    "lib/shibkit/meta_meta/attribute.rb",
    "lib/shibkit/meta_meta/config.rb",
    "lib/shibkit/meta_meta/contact.rb",
    "lib/shibkit/meta_meta/data/default_metadata/example_federation_metadata.xml",
    "lib/shibkit/meta_meta/data/default_metadata/local_metadata.xml",
    "lib/shibkit/meta_meta/data/default_metadata/uncommon_federation_metadata.xml",
    "lib/shibkit/meta_meta/data/default_metadata_cache.yml",
    "lib/shibkit/meta_meta/data/dev_sources.yml",
    "lib/shibkit/meta_meta/data/real_sources.yml",
    "lib/shibkit/meta_meta/entity.rb",
    "lib/shibkit/meta_meta/federation.rb",
    "lib/shibkit/meta_meta/idp.rb",
    "lib/shibkit/meta_meta/logo.rb",
    "lib/shibkit/meta_meta/metadata_item.rb",
    "lib/shibkit/meta_meta/mixin/cached_downloads.rb",
    "lib/shibkit/meta_meta/mixin/xpath_chores.rb",
    "lib/shibkit/meta_meta/organisation.rb",
    "lib/shibkit/meta_meta/provider.rb",
    "lib/shibkit/meta_meta/provisioning/base.rb",
    "lib/shibkit/meta_meta/requested_attribute.rb",
    "lib/shibkit/meta_meta/service.rb",
    "lib/shibkit/meta_meta/source.rb",
    "lib/shibkit/meta_meta/sp.rb",
    "shibkit-meta_meta.gemspec",
    "spec/meta_meta/config/autoloading_and_refreshing_spec.rb",
    "spec/meta_meta/config/code_nspec.rb",
    "spec/meta_meta/config/configuration_spec.rb",
    "spec/meta_meta/config/creation_spec.rb",
    "spec/meta_meta/config/downloading_and_caching_settings_spec.rb",
    "spec/meta_meta/config/env_platform_settings.rb",
    "spec/meta_meta/config/filtering_settings_spec.rb",
    "spec/meta_meta/config/init.rb",
    "spec/meta_meta/config/logger_settings_spec.rb",
    "spec/meta_meta/config/smartcache_settings_spec.rb",
    "spec/meta_meta/config/source_file_settings_spec.rb",
    "spec/meta_meta/config/tagging_settings_spec.rb",
    "spec/meta_meta/config/working_directory_settings_spec.rb",
    "spec/meta_meta/config/xml_processing_settings_spec.rb",
    "spec/meta_meta/contact/contact_oldspec.rb",
    "spec/meta_meta/entity/entity_oldspec.rb",
    "spec/meta_meta/federation/federation_oldspec.rb",
    "spec/meta_meta/meta_meta/cache_example.yaml",
    "spec/meta_meta/meta_meta/meta_meta_spec.rb",
    "spec/meta_meta/meta_meta/saved_sources.yaml",
    "spec/meta_meta/organisation/organisation_oldspec.rb",
    "spec/meta_meta/source/application_extras_spec.rb",
    "spec/meta_meta/source/conversion_spec.rb",
    "spec/meta_meta/source/creation_spec.rb",
    "spec/meta_meta/source/downloads_and_caching_spec.rb",
    "spec/meta_meta/source/federation_information_spec.rb",
    "spec/meta_meta/source/fixtures.rb",
    "spec/meta_meta/source/init.rb",
    "spec/meta_meta/source/loading_and_saving_spec.rb",
    "spec/meta_meta/source/metadata_details_spec.rb",
    "spec/meta_meta/source/metadata_integrity_spec.rb",
    "spec/meta_meta/source/selection_spec.rb",
    "spec/meta_meta/source/source_oldspec.rb",
    "spec/meta_meta/source/xml_parsing_spec.rb",
    "spec/meta_meta/template",
    "spec/moi/config_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/support/supply_xml.rb"
  ]
  s.homepage = %q{http://github.com/binaryape/shibkit-meta_meta}
  s.licenses = [%q{Apache 2.0}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.8}
  s.summary = %q{Downloads and parses Shibboleth (SAML2) metadata.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client-components>, [">= 0"])
      s.add_runtime_dependency(%q<rack-cache>, [">= 0"])
      s.add_runtime_dependency(%q<addressable>, [">= 0"])
      s.add_runtime_dependency(%q<chunky_png>, [">= 0"])
      s.add_runtime_dependency(%q<dimensions>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<rest-client-components>, [">= 0"])
      s.add_dependency(%q<rack-cache>, [">= 0"])
      s.add_dependency(%q<addressable>, [">= 0"])
      s.add_dependency(%q<chunky_png>, [">= 0"])
      s.add_dependency(%q<dimensions>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<rest-client-components>, [">= 0"])
    s.add_dependency(%q<rack-cache>, [">= 0"])
    s.add_dependency(%q<addressable>, [">= 0"])
    s.add_dependency(%q<chunky_png>, [">= 0"])
    s.add_dependency(%q<dimensions>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.7.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
  end
end

