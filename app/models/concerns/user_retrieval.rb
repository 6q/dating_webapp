module UserRetrieval
  extend ActiveSupport::Concern

  def build_query(not_in, limit = 20, order_type = :by_visits)
    order = {
      :by_visits => 'p.main IS NULL, distance ASC, visits_count DESC, pictures_count DESC, likes_count DESC, cellove_index DESC',
      :by_likes => 'p.main IS NULL, distance ASC, likes_count DESC, pictures_count DESC, visits_count DESC, cellove_index DESC',
      :by_index => 'p.main IS NULL, distance ASC, cellove_index DESC, pictures_count DESC, likes_count DESC, visits_count DESC',
      :by_recent => 'p.main IS NULL, distance ASC, users.created_at DESC, pictures_count DESC, likes_count DESC, visits_count DESC, cellove_index DESC',
      :by_pictures => 'p.main IS NULL, distance ASC, pictures_count DESC, users.created_at DESC, likes_count DESC, visits_count DESC, cellove_index DESC',
    }

      # Ordre original
      #
      # :by_visits => 'p.main IS NULL, visits_count DESC, likes_count DESC, distance ASC, messages_count DESC, cellove_index DESC',
      # :by_likes => 'p.main IS NULL, likes_count DESC, visits_count DESC, messages_count DESC, distance ASC, cellove_index DESC',
      # :by_index => 'p.main IS NULL, cellove_index DESC, likes_count DESC, visits_count DESC, messages_count DESC, distance ASC',
      # :by_recent => 'p.main IS NULL, users.created_at DESC, distance ASC, likes_count DESC, visits_count DESC, messages_count DESC, cellove_index DESC',

    #.joins('LEFT JOIN (SELECT receiver_id, COUNT(*) AS cnt FROM receipts WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY receiver_id) r ON r.receiver_id = users.id')

    query = self.nearbys(100000).select('COALESCE(v.cnt, 0) as visits_count, COALESCE(l.cnt, 0) as likes_count, COALESCE(d.cnt, 0) as pictures_count')
    .joins('LEFT JOIN (SELECT attachable_id, COUNT(*) AS cnt FROM pictures GROUP BY attachable_id) d ON d.attachable_id = users.id')
    .joins('LEFT JOIN (SELECT user_id, COUNT(*) AS cnt FROM user_visits WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY user_id) v ON v.user_id = users.id')
    .joins('LEFT JOIN (SELECT user_id, COUNT(*) AS cnt FROM likes WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 50 day) GROUP BY user_id) l ON l.user_id = users.id')
    .joins('LEFT JOIN pictures p ON p.attachable_id = users.id')
    .where("users.id NOT IN (?)", not_in)
    .where("users.gender = ?", self.matching_gender)
    .where("users.lf_gender = ?", self.gender)
    .reorder(order[order_type])
    .limit(limit)
    .uniq

    if self.lf_age_from.present? && self.lf_age_to.present?
      query = query.where('birth_date <= ?', self.lf_age_from.to_i.years.ago.beginning_of_year)
      query = query.where('birth_date >= ?', self.lf_age_to.to_i.years.ago.end_of_year)
    end

    query
  end

  def retrieve_users(limit = 20, order_type = :by_visits, exclude = [])
    @last_query ||= []
    exclude     ||= []
    result = build_query(self.get_all_invisible_to_me + @last_query + exclude, limit, order_type)

    result_ids = result.map(&:id)
    @last_query += result_ids
    result
  end

  def best_suited_near_me(limit = 12, exclude = [])
    retrieve_users(limit, :by_pictures, exclude)
  end

  def could_interest_me(limit = 20, exclude = [])
    retrieve_users(limit, :by_likes, exclude)
  end

  def best_index(limit = 20, exclude = [])
    retrieve_users(limit, :by_index, exclude)
  end

  def new_users_near_me(limit = 20, exclude = [])
    retrieve_users(limit, :by_recent, exclude)
  end
end
