module UserRetrieval
  extend ActiveSupport::Concern

  SUPER_QUERY = <<-EOF
  SELECT users.*, COALESCE(v.cnt, 0) as visits_count, COALESCE(l.cnt, 0) as likes_count, COALESCE(r.cnt, 0) as messages_count
  FROM users
  LEFT JOIN
    (SELECT user_id, COUNT(*) AS cnt FROM user_visits WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY user_id) v
  ON v.user_id = users.id
  LEFT JOIN 
    (SELECT user_id, COUNT(*) AS cnt FROM likes WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY user_id) l
  ON l.user_id = users.id
  LEFT JOIN
    (SELECT receiver_id, COUNT(*) AS cnt FROM receipts WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY receiver_id) r
  ON r.receiver_id = users.id
  WHERE users.id NOT IN (1)
  GROUP BY users.id
  ORDER BY visits_count DESC, likes_count DESC, messages_count DESC, cellove_index DESC
  LIMIT 5
EOF

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

    best = User.find_by_sql(SUPER_QUERY)
    # max = 0

    # begin
    #   if near = nearbys(radius)
    #     hidden_user_ids = self.get_all_invisible_to_me
    #     most_visited = UserVisit.select(:user_id).select('count(user_id)').group(:user_id).map {|u| u.user_id}

    #     most_visited -= hidden_user_ids
    #     best = near.where(id: most_visited)
    #     .where(gender: self.matching_gender)
    #     .limit(how_many).sample(how_many)
    #   end
    #   radius += 100
    #   max += 1
    # end while(best.count < 5 && max < 5)

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
