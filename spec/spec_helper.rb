require 'rubygems'
gem 'rspec'
 
require 'spec'
 
$:<< File.join(File.dirname(__FILE__), '..', 'lib')
 
 
SPEC_DIR = File.dirname(__FILE__) unless defined? SPEC_DIR
$:<< SPEC_DIR
 
require 'comp_scraper'