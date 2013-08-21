module UserRetrieval
  extend ActiveSupport::Concern

  def best_rated(radius = User::DEFAULT_NEARBY_DISTANCE)
    if near = nearbys(radius)
      hidden_user_ids = self.get_all_invisible_to_me
      best = near.where("users.id NOT IN (?)", hidden_user_ids)
        .where(gender: self.matching_gender)
        .limit(20)
        .group(:id)
        .order('cellove_index DESC').sample(5)
    end

    best
  end

  def best_suited_near_me(how_many = 5, radius = User::DEFAULT_NEARBY_DISTANCE)
    max = 0

    begin
      if near = nearbys(radius)
        hidden_user_ids = self.get_all_invisible_to_me
        most_visited = UserVisit.select(:user_id).select('count(user_id)').group(:user_id).map {|u| u.user_id}

        most_visited -= hidden_user_ids
        best = near.where(id: most_visited)
        .where(gender: self.matching_gender)
        .limit(how_many).sample(how_many)
      end
      radius += 100
      max += 1
    end while(best.count < 5 && max < 5)

    best
  end

  def new_users_near_me(radius = User::DEFAULT_NEARBY_DISTANCE)
    new_near = []

    if near = nearbys(radius)
      hidden_user_ids = self.get_all_invisible_to_me
      new_near = near.where("users.id NOT IN (?)", hidden_user_ids)
        .where(gender: self.matching_gender)
        .limit(20).sample(5)
    end
    new_near
  end
end
