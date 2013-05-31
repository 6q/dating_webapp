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
    hidden_user_ids = self.get_all_invisible_to_me
    nearbys(User::DEFAULT_NEARBY_DISTANCE).where("users.id NOT IN (?)", hidden_user_ids).limit(5)
  end

end
