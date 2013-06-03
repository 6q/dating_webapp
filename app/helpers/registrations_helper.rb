#encoding: utf-8
module RegistrationsHelper
  def gender_options
    User::GENDER.map {|k,v| [v,k]}
  end

  def orientation_options
    User::ORIENTATION.map {|k,v| [v,k]}
  end

  def marital_status_options
    User::MARITAL_STATUS.map {|k,v| [v,k]}
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

  def language_options
    User::LANGUAGE.map {|k,v| [v,k]} 
  end

  def language_level_options
    User::LANGUAGE_LEVEL.map {|k,v| [v,k]} 
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


  def lf_relationship_options
    User::LF_RELATIONSHIP.map {|k,v| [v,k]}
  end

  def lf_house_options
    User::LF_HOUSE.map {|k,v| [v,k]}
  end

  def lf_child_options
    User::LF_CHILD.map {|k,v| [v,k]}
  end

  def lf_smoke_options
    User::LF_SMOKE.map {|k,v| [v,k]}
  end

  def lf_party_options
    User::LF_PARTY.map {|k,v| [v,k]}
  end

  def lf_diet_options
    User::LF_DIET.map {|k,v| [v,k]}
  end

  def lf_alcohol_options
    User::LF_ALCOHOL.map {|k,v| [v,k]}
  end

  def lf_religion_activity_options
    User::LF_RELIGION_ACTIVITY.map {|k,v| [v,k]}
  end

  def lf_animals_options
    User::LF_ANIMALS.map {|k,v| [v,k]}
  end

  def lf_child_options
    User::LF_CHILD.map {|k,v| [v,k]}
  end




end
