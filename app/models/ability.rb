class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :delete, Post, author_id: user.id
      can :delete, Comment, user_id: user.id
      can :read, Post, author_id: user.id
    end
  end
end
