module UserRetrieval
  extend ActiveSupport::Concern

  def new_users_near_me
    #TODO: Implement
    5.times.map{ self.class.all.sample }
  end

  def best_rated_near_me
    #TODO: Implement
    5.times.map{ self.class.all.sample }
  end

  def best_suited_near_me
    #TODO: Implement
    5.times.map{ self.class.all.sample }
  end
end
