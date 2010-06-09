require 'fileutils'

module HostAppHelper

  HOST_APP_ROOT = '/tmp/resource_awareness_host_app' unless defined? HOST_APP_ROOT
  RESOURCE_AWARENESS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined? RESOURCE_AWARENESS_ROOT

  def recreate_host_app
    FileUtils.rm_rf(HOST_APP_ROOT) if File.exist?(HOST_APP_ROOT)
    %x[RESOURCE_AWARENESS_ROOT='#{RESOURCE_AWARENESS_ROOT}' rails new #{HOST_APP_ROOT} --template=#{RESOURCE_AWARENESS_ROOT}/test/host_app_template.rb --quiet]
  end

  def load_host_app
    Dir.chdir(HOST_APP_ROOT) do
      require File.expand_path(File.join(HOST_APP_ROOT, 'config', 'environment.rb'))
    end
  end

  def execute_in_host_app_root(command)
    Dir.chdir(HOST_APP_ROOT) do
      %x[#{command}]
    end
  end

  def generate_resource_layout(name)
    FileUtils.cp(RESOURCE_AWARENESS_ROOT + "/test/fixtures/#{name}_resource_layout.rb", HOST_APP_ROOT + "/config/resource_layout.rb")
    execute_in_host_app_root('rails generate resource_layout --generator=ingoweiss:scaffold')
  end

  def migrate_host_app_db
    Dir.chdir(HOST_APP_ROOT) do
      %x[rake db:migrate db:schema:dump db:test:clone_structure]
    end
  end


end