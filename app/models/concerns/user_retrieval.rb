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

  def new_users_near_me
    hidden_user_ids = self.hidden_user_ids.concat(self.invisible_to_me)
    nearbys(50).where("users.id NOT IN (?)", hidden_user_ids).limit(5)
  end

  # module ClassMethods
  #   def new_users_near_me(user)
  #     nearby = near(user, 50).where("id != ?", user.id)
  #     nearby_users = includes(:user_hides).where(:user_hides => { :hidden_user_id => nil, :user_id => nil }).where('users.id in (?)', nearby).limit(5)
  #   end
  # end
end
