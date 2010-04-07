ENV["RAILS_ENV"] = "test"
require 'rubygems'

require File.join(File.dirname(__FILE__), 'host_app_helper')
include HostAppHelper

recreate_host_app
load_host_app

require 'rails/test_help'
