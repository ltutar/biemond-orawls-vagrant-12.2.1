require File.dirname(__FILE__) + '/../../orawls_core'


module Puppet
  Type.newtype(:wls_jms_subdeployment) do
    include EasyType
    include Utils::WlsAccess
    extend Utils::TitleParser

    desc 'This resource allows you to manage a JMS subdeployment in a JMS module of an WebLogic domain.'

    ensurable

    set_command(:wlst)

    to_get_raw_resources do
      Puppet.info "index #{name}"
      environment = { 'action' => 'index', 'type' => 'wls_jms_subdeployment' }
      wlst template('puppet:///modules/orawls/providers/wls_jms_subdeployment/index.py.erb', binding), environment
    end

    on_create  do | command_builder |
      wlst_action = 'create'
      Puppet.info "create #{name}"
      template('puppet:///modules/orawls/providers/wls_jms_subdeployment/create_modify.py.erb', binding)
    end

    on_modify  do | command_builder |
      wlst_action = 'modify'
      Puppet.info "modify #{name} "
      template('puppet:///modules/orawls/providers/wls_jms_subdeployment/create_modify.py.erb', binding)
    end

    on_destroy  do | command_builder |
      Puppet.info "destroy #{name} "
      template('puppet:///modules/orawls/providers/wls_jms_subdeployment/destroy.py.erb', binding)
    end

    parameter :domain
    parameter :name
    parameter :subdeployment_name
    parameter :jmsmodule
    parameter :timeout
    property :target
    property :targettype

    add_title_attributes(:jmsmodule, :subdeployment_name) do
      /^((.*\/)?(.*):(.*)?)$/
    end

  end
end
