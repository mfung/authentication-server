class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    # insert your can, cannot and any other rule statements here
    #cannot :manage, User
    cannot :manage, User
    # use any licenses here
  end

  def dynamic_rules
    can :manage, User, :id => user.id
  end

  module Cached
    def permit_rules
    end
  end

  module NonCached
    def permit_rules
    end
  end
end
