CanTango.config do |config|

  config.engines.all :on
  # more configuration here...
  
  config.autoload.models :on
  config.autoload.permits :on
  
  #config.roles.clear!
  config.roles.role_system = :simple_roles
  config.roles.list_method = :roles
  config.roles.has_method = :has_role?
  
  config.permits.enable_all_for :roles
  config.permits.disable :role_groups, :special, :user_type, :account_type
  
  #config.enable_helpers :rest
  
  config.user.unique_key_field = :email

  config.engine(:permit).set :on
  config.engine(:permission).set :off
  config.engine(:user_ac).set :off
  config.engine(:cache).set :off
  config.ability.mode = :no_cache

  #config.debug!
end
