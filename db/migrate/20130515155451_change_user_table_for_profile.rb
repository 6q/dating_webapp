class ChangeUserTableForProfile < ActiveRecord::Migration
  def up
    add_column :users, :lf_house, :text
    add_column :users, :lf_hair, :text
    add_column :users, :lf_hair_style, :text
    add_column :users, :lf_eyes, :text
    add_column :users, :lf_like_sport, :boolean
    add_column :users, :lf_like_read, :boolean
    add_column :users, :lf_like_cinema, :boolean
    add_column :users, :lf_like_quiet, :boolean
    add_column :users, :lf_like_walk, :boolean
    add_column :users, :lf_like_mountain, :boolean
    add_column :users, :lf_like_beach, :boolean
    add_column :users, :lf_like_family, :boolean
    add_column :users, :lf_like_friends, :boolean
    add_column :users, :lf_religion_activity, :text
    add_column :users, :lf_citizenship, :text
    add_column :users, :lf_ethnicity, :text
    add_column :users, :lf_animals, :text
    add_column :users, :lf_party, :text
    add_column :users, :lf_language_level, :text
    remove_column :users, :lf_child_want
    remove_column :users, :lf_smoke_tolerance
    remove_column :users, :lf_drugs
    remove_column :users, :lf_drug_frequency
    remove_column :users, :lf_religion_opinion
    remove_column :users, :lf_animal_like
    remove_column :users, :lf_animal_have
  end

  def down
    remove_column :users, :lf_house
    remove_column :users, :lf_hair
    remove_column :users, :lf_hair_style
    remove_column :users, :lf_eyes
    remove_column :users, :lf_like_sport
    remove_column :users, :lf_like_read
    remove_column :users, :lf_like_cinema
    remove_column :users, :lf_like_quiet
    remove_column :users, :lf_like_walk
    remove_column :users, :lf_like_mountain
    remove_column :users, :lf_like_beach
    remove_column :users, :lf_like_family
    remove_column :users, :lf_like_friends
    remove_column :users, :lf_religion_activity
    remove_column :users, :lf_citizenship
    remove_column :users, :lf_ethnicity
    remove_column :users, :lf_animals
    remove_column :users, :lf_party
    remove_column :users, :lf_language_level
    add_column :users, :lf_child_want, :string
    add_column :users, :lf_smoke_tolerance, :string
    add_column :users, :lf_drugs, :string
    add_column :users, :lf_drug_frequency, :string
    add_column :users, :lf_religion_opinion, :string
    add_column :users, :lf_animal_like, :string
    add_column :users, :lf_animal_have, :string
  end
end
