#encoding: utf-8
module RegistrationsHelper
  def gender_options
    User::GENDER.map {|e| [t(e), e]}
  end

  def orientation_options
    User::ORIENTATION.map {|e| [t(e), e]}
  end

  def marital_status_options
    User::MARITAL_STATUS.map {|e| [t(e), e]}
  end

  def country_options
    ["España"]
  end

  def child_options
    User::CHILD.map {|e| [t(e), e]}
  end

  def house_options
    User::HOUSE.map {|e| [t(e),e]}
  end

  def physical_desc_options
    User::PHYSICAL_DESC.map {|e| [t(e), e]}
  end

  def physical_style_options
    User::PHYSICAL_STYLE.map {|e| [t(e), e]}
  end

  def eyes_options
    User::EYES.map {|e| [t(e), e]}
  end

  def hair_options
    User::HAIR.map {|e| [t(e), e]}
  end

  def hair_style_options
    User::HAIR_STYLE.map {|e| [t(e), e]}
  end

  def complexion_options
    User::COMPLEXION.map {|e| [t(e), e]}
  end

  def smoke_options
    User::SMOKE.map {|e| [t(e), e]}
  end

  def religion_options
    User::RELIGION.map {|e| [t(e), e]}
  end

  def ethnicity_options
    User::ETHNICITY.map {|e| [t(e), e]}
  end

  def study_level_options
    User::STUDY_LEVEL.map {|e| [t(e), e]}
  end

  def job_options
    User::JOB.map {|e| [t(e), e]}
  end

  def diet_options
    User::DIET.map {|e| [t(e), e]}
  end

  def alcohol_options
    User::ALCOHOL.map {|e| [t(e), e]}
  end

  def wedding_opinion_options
    User::WEDDING_OPINION.map {|e| [t(e), e]}
  end

  def religion_activity
    User::RELIGION_ACTIVITY.map {|e| [t(e), e]}
  end

  def animals_options
    User::ANIMALS.map {|e| [t(e), e]}
  end

  def party_options
    User::PARTY.map {|e| [t(e), e]}
  end

  def music_options
    User::MUSIC.map {|e| [t(e), e]}
  end

  def music_genre_options
    User::MUSIC_GENRE.map {|e| [t(e), e]}
  end

  def cinema_options
    User::CINEMA.map {|e| [t(e), e]}
  end

  def cinema_frequency_options
    User::CINEMA_FREQUENCY.map {|e| [t(e), e]}
  end

  def cinema_genre_options
    User::CINEMA_GENRE.map {|e| [t(e), e]}
  end



  def lf_child_options
    User::LF_CHILD.map {|e| [t(e), e]}
  end

  def lf_child_want_options
    User::LF_CHILD_WANT.map {|e| [t(e), e]}
  end

  def lf_smoke_options
    User::LF_SMOKE.map {|e| [t(e), e]}
  end

  def lf_smoke_tolerance_options
    User::LF_SMOKE_TOLERANCE.map {|e| [t(e), e]}
  end

  def lf_diet_options
    User::LF_DIET.map {|e| [t(e), e]}
  end

  def lf_alcohol_options
    User::LF_ALCOHOL.map {|e| [t(e), e]}
  end

  def lf_drugs_options
    User::LF_DRUGS.map {|e| [t(e), e]}
  end

  def lf_animal_like_options
    User::LF_ANIMAL_LIKE.map {|e| [t(e), e]}
  end

  def lf_animal_have_options
    User::LF_ANIMAL_HAVE.map {|e| [t(e), e]}
  end



end
