class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?

      can :manage, :all  # Admins can perform any action on any model, including destroy
      can :access, :audit_log

    elsif user.manager?

      can :manage, Project  # Managers can create, read, update, and destroy Projects
      can :manage, Task       # Managers can only read Tasks
  
    else user.team_member?

      can :read, Project    # Team members can read Projects
      can :manage, Task   # Team members can create Tasks
      cannot :destroy, Task  # Team members cannot destroy Projects
      cannot :destroy, Meeting  # Team members cannot destroy Projects
      
    end
    
  end
end
