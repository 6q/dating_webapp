module UserRetrieval
  extend ActiveSupport::Concern

  def build_query(not_in, limit, order_type = :by_visits)
    order = {
      :by_visits => 'visits_count DESC, likes_count DESC, messages_count DESC, cellove_index DESC ',
      :by_likes => 'likes_count DESC, visits_count DESC, messages_count DESC, cellove_index DESC ',
      :by_index => 'cellove_index DESC, likes_count DESC, visits_count DESC, messages_count DESC ',
      :by_recent => 'users.created_at DESC, likes_count DESC, visits_count DESC, messages_count DESC, cellove_index DESC ',
    }
    query = <<-EOF
      SELECT users.*, COALESCE(v.cnt, 0) as visits_count, COALESCE(l.cnt, 0) as likes_count, COALESCE(r.cnt, 0) as messages_count, p.main
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
    EOF

    query += "LEFT JOIN pictures p ON p.attachable_id = users.id "
    query += "WHERE users.id NOT IN (#{not_in.join(',')}) "
    query += "AND gender = '#{self.matching_gender}' "
    if self.lf_age_from.present? && self.lf_age_to.present?
      query += "AND birth_date <= '#{self.lf_age_from.to_i.years.ago.beginning_of_year}' "
      query += "AND birth_date >= '#{self.lf_age_to.to_i.years.ago.end_of_year}' "
    end
    query += "GROUP BY users.id "
    query += "ORDER BY p.main DESC, #{order[order_type]} "
    query += "LIMIT #{limit}"
  end

  def retrieve_users(limit = 20, order_type = :by_visits)
    @last_query ||= []
    result = User.find_by_sql(build_query(self.get_all_invisible_to_me + @last_query, limit, order_type))
    result_ids = result.map {|b| b.id}
    @last_query += result_ids

    result = self.nearbys(100000).where(id: result_ids)
    result
  end

  def best_suited_near_me
    retrieve_users
  end

  def could_interest_me(limit = 20)
    retrieve_users(limit, :by_likes)
  end

  def best_index(limit = 20)
    retrieve_users(limit, :by_index)
  end

  def new_users_near_me(limit = 20)
    retrieve_users(limit, :by_recent)
  end
end
