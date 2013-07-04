module UserRetrieval
  extend ActiveSupport::Concern

  def best_rated
    hidden_user_ids = self.get_all_invisible_to_me
    best = self.class.where("users.id NOT IN (?)", hidden_user_ids)
      .where("users.gender = ?", self.matching_gender)
      .limit(5)
      .group('users.id')
      .includes(:rates)
      .order('AVG(rates.stars) DESC')
    best
  end

  def best_suited_near_me(how_many = 5)
    #TODO: Implement
    if near = nearbys(User::DEFAULT_NEARBY_DISTANCE)
      hidden_user_ids = self.get_all_invisible_to_me
      new_near = near.where("users.id NOT IN (?)", hidden_user_ids)
        .where("users.gender = ?", self.matching_gender)
        .where("users.postal_code = :postal_code", postal_code: self.matching_postal_code)
        .limit(how_many)

        if new_near.count == 0
          hidden_user_ids = self.get_all_invisible_to_me
          new_near = near.where("users.id NOT IN (?)", hidden_user_ids)
          .where("users.gender = ?", self.matching_gender)
          .limit(how_many)
        end
    end

    new_near
  end

  def new_users_near_me
    new_near = []

    if near = nearbys(User::DEFAULT_NEARBY_DISTANCE)
      hidden_user_ids = self.get_all_invisible_to_me
      new_near = near.where("users.id NOT IN (?)", hidden_user_ids)
        .where("users.gender = ?", self.matching_gender)
        .limit(5)
    end
    new_near
  end
end
