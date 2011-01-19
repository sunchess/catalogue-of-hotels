class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    else
      can :read, [Place, Image, Hotel, Room, Price]
      if user.confirmed_at #is real user
        can :create, Place
        can :create, Image
        can :create, Hotel
        can :create, Room
        can :create, Price
        can :create, Reserf
        
        can :read, Reserf, :user_id=>user.id
        can [:update, :destroy], Reserf do |reserve|
          reserve.try(:user) == user and reserve.status < 2
        end

        can :update, Hotel do |hotel|
          hotel.try(:user) == user
        end

        can :update, Room do |room|
          room.try(:hotel).try(:user) == user
        end

      else
        cannot :read, DynamicField
        cannot :read, DynamicModel
      end

      #can :create, Comment
      #can :update, Comment do |comment|
      #  comment.try(:user) == user || user.role?(:moderator)
      #end
      #if user.role?(:author)
      #  can :create, Article
      #  can :update, Article do |article|
      #    article.try(:user) == user
      #  end
      #end
    end
  end
end
