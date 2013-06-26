class ProfileCompleteness
  COMO_ERES_1 = %w[gender orientation marital_status birth_date postal_code city country]
  COMO_ERES_2 = %w[marital_status child house]
  COMO_ERES_3 = %w[physical_desc height weight complexion eyes hair hair_style physical_style]
  COMO_ERES_4 = %w[religion religion_activity citizenship ethnicity]
  COMO_ERES_5 = %w[study_level language language_level job salary]
  COMO_ERES_6 = %w[description]
  COMO_ERES_7 = %w[my_characteristics]

  GUSTOS_1 = %w[diet]
  GUSTOS_2 = %w[smoke alcohol]
  GUSTOS_3 = %w[wedding_opinion]
  GUSTOS_4 = %w[animals]
  GUSTOS_5 = %w[party music music_genre cinema cinema_frequency cinema_genre]

  QUE_BUSCAS_1 = %w[lf_gender lf_orientation lf_marital_status lf_age_between lf_age_to lf_relationship lf_child lf_house lf_city lf_country lf_postal_code]
  QUE_BUSCAS_2 = %w[lf_physical_desc lf_physical_style lf_height_between lf_height_to lf_weight_between lf_weight_to lf_complexion lf_hair lf_hair_style lf_eyes]
  QUE_BUSCAS_3 = %w[lf_smoke lf_alcohol lf_party lf_diet]
  QUE_BUSCAS_4 = %w[lf_ethnicity lf_citizenship lf_religion lf_religion_activity lf_animals]
  QUE_BUSCAS_5 = %w[lf_study_level lf_language lf_language_level lf_job lf_salary]
  QUE_BUSCAS_6 = %w[]

  def initialize(user)
    @user = user
  end

  def get_profile_completeness
    total = 0
    total += 1 if como_eres_1
    total += 1 if como_eres_2
    total += 1 if como_eres_3
    total += 1 if como_eres_4
    total += 1 if como_eres_5
    total += 1 if como_eres_6
    total += 1 if como_eres_7

    total += 1 if gustos_1
    total += 1 if gustos_2
    total += 1 if gustos_3
    total += 1 if gustos_4
    total += 1 if gustos_5

    total += 1 if que_buscas_1
    total += 1 if que_buscas_2
    total += 1 if que_buscas_3
    total += 1 if que_buscas_4
    total += 1 if que_buscas_5
    total += 1 if que_buscas_6

    return (total/18.0)*100
  end

  private
    def is_complete?(fields)
      fields.each do |field|
        if @user[field.to_sym].blank?
          return false
        end
      end
      true
    end

    def como_eres_1
      is_complete?(COMO_ERES_1)
    end
    def como_eres_2
      is_complete?(COMO_ERES_2)
    end
    def como_eres_3
      is_complete?(COMO_ERES_3)
    end
    def como_eres_4
      is_complete?(COMO_ERES_4)
    end
    def como_eres_5
      is_complete?(COMO_ERES_5)
    end
    def como_eres_6
      is_complete?(COMO_ERES_6)
    end
    def como_eres_7
      !@user.my_characteristics.nil?
    end

    def gustos_1
      is_complete?(GUSTOS_1)
    end
    def gustos_2
      is_complete?(GUSTOS_2)
    end
    def gustos_3
      is_complete?(GUSTOS_3)
    end
    def gustos_4
      is_complete?(GUSTOS_4)
    end
    def gustos_5
      is_complete?(GUSTOS_5)
    end

    def que_buscas_1
      is_complete?(QUE_BUSCAS_1)
    end
    def que_buscas_2
      is_complete?(QUE_BUSCAS_2)
    end
    def que_buscas_3
      is_complete?(QUE_BUSCAS_3)
    end
    def que_buscas_4
      is_complete?(QUE_BUSCAS_4)
    end
    def que_buscas_5
      is_complete?(QUE_BUSCAS_5)
    end
    def que_buscas_6
      is_complete?(QUE_BUSCAS_6)
    end
end
