module UserRetrieval
  extend ActiveSupport::Concern

  def best_rated_near_me
    #TODO: Implement
    5.times.map{ self.class.all.sample }
  end

  def best_suited_near_me(how_many = 5)
    #TODO: Implement
    how_many.times.map{ self.class.all.sample }
  end

  module ClassMethods
    def new_users_near_me(user)
      # This query should work, but doesn't cause Geocoder sucks
      # Read: https://github.com/alexreisner/geocoder#known-issue
      #near(user, 50).where("users.id != ?", user.id).includes(:user_hides).where(:user_hides => { :hidden_user_id => nil, :user_id => nil }).limit(5)
      # Instead, we'll have to filter users manually
      nearby = near(user, 50).where("id != ?", user.id)
      users = []
      nearby.each do |nearby_user|
        if !user.hidden_users.any?{ |u| u.id == nearby_user.id }
          users.push(nearby_user)
        end
        if users.length == 5
          return users
        end
      end
      return users
    end
  end
end
