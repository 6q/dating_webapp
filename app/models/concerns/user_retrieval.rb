module UserRetrieval
  extend ActiveSupport::Concern

  def build_query(not_in, order_type = :by_visits, limit = 20)
    order = {
      :by_visits => 'visits_count DESC, likes_count DESC, messages_count DESC, cellove_index DESC ',
      :by_likes => 'likes_count DESC, visits_count DESC, messages_count DESC, cellove_index DESC ',
    }
    query = <<-EOF
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
    EOF

    query += "WHERE users.id NOT IN (#{not_in.join(',')}) "
    query += "AND gender = '#{self.matching_gender}' "
    query += "GROUP BY users.id "
    query += "ORDER BY #{order[order_type]} "
    query += "LIMIT #{limit}"
  end

  def best_suited_near_me
    result = User.find_by_sql(build_query(self.get_all_invisible_to_me))
    @last_query = result.map {|b| b.id}
    result
  end

  def could_interest_me
    result = User.find_by_sql(build_query(self.get_all_invisible_to_me + @last_query))
    @last_query += result.map {|b| b.id}
    result
  end

  def best_index
    result = User.find_by_sql(build_query(self.get_all_invisible_to_me + @last_query))
    @last_query += result.map {|b| b.id}
    result
  end

  def new_users_near_me
    result = User.find_by_sql(build_query(self.get_all_invisible_to_me + @last_query))
    @last_query += result.map {|b| b.id}
    result
  end
end
