#encoding: utf-8
module RegistrationsHelper
  def gender_options
    #User::GENDER.map {|k,v| [v,k]}
    User::GENDER.map {|k,v| [_(k),k]}
  end

  def orientation_options
    User::ORIENTATION.map {|k,v| [_(k),k]}
  end

  def marital_status_options
    User::MARITAL_STATUS.map {|k,v| [_(k),k]}
  end

  def country_options
    ["España"]
  end

  def child_options
    User::CHILD.map {|k,v| [v,k]}
  end

  def house_options
    User::HOUSE.map {|k,v| [v,k]}
  end

  def physical_desc_options
    User::PHYSICAL_DESC.map {|k,v| [v,k]}
  end

  def physical_style_options
    User::PHYSICAL_STYLE.map {|k,v| [v,k]}
  end

  def eyes_options
    User::EYES.map {|k,v| [v,k]}
  end

  def hair_options
    User::HAIR.map {|k,v| [v,k]}
  end

  def hair_style_options
    User::HAIR_STYLE.map {|k,v| [v,k]}
  end

  def complexion_options
    User::COMPLEXION.map {|k,v| [v,k]}
  end

  def smoke_options
    User::SMOKE.map {|k,v| [v,k]}
  end

  def religion_options
    User::RELIGION.map {|k,v| [v,k]}
  end

  def ethnicity_options
    User::ETHNICITY.map {|k,v| [v,k]}
  end

  def study_level_options
    User::STUDY_LEVEL.map {|k,v| [v,k]}
  end

  def job_options
    User::JOB.map {|k,v| [v,k]}
  end

  def diet_options
    User::DIET.map {|k,v| [v,k]}
  end

  def alcohol_options
    User::ALCOHOL.map {|k,v| [v,k]}
  end

  def wedding_opinion_options
    User::WEDDING_OPINION.map {|k,v| [v,k]}
  end

  def religion_activity_options
    User::RELIGION_ACTIVITY.map {|k,v| [v,k]}
  end

  def animals_options
    User::ANIMALS.map {|k,v| [v,k]}
  end

  def party_options
    User::PARTY.map {|k,v| [v,k]}
  end

  def music_options
    User::MUSIC.map {|k,v| [v,k]}
  end

  def music_genre_options
    User::MUSIC_GENRE.map {|k,v| [v,k]}
  end

  def cinema_options
    User::CINEMA.map {|k,v| [v,k]}
  end

  def cinema_frequency_options
    User::CINEMA_FREQUENCY.map {|k,v| [v,k]}
  end

  def cinema_genre_options
    User::CINEMA_GENRE.map {|k,v| [v,k]}
  end



  def lf_child_options
    User::LF_CHILD.map {|k,v| [v,k]}
  end

  def lf_child_want_options
    User::LF_CHILD_WANT.map {|k,v| [v,k]}
  end

  def lf_smoke_options
    User::LF_SMOKE.map {|k,v| [v,k]}
  end

  def lf_smoke_tolerance_options
    User::LF_SMOKE_TOLERANCE.map {|k,v| [v,k]}
  end

  def lf_diet_options
    User::LF_DIET.map {|k,v| [v,k]}
  end

  def lf_alcohol_options
    User::LF_ALCOHOL.map {|k,v| [v,k]}
  end

  def lf_drugs_options
    User::LF_DRUGS.map {|k,v| [v,k]}
  end

  def lf_animal_like_options
    User::LF_ANIMAL_LIKE.map {|k,v| [v,k]}
  end

  def lf_animal_have_options
    User::LF_ANIMAL_HAVE.map {|k,v| [v,k]}
  end



end
