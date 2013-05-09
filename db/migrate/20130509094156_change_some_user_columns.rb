class ChangeSomeUserColumns < ActiveRecord::Migration
	def up
		add_column :users, :house, :string
		add_column :users, :eyes, :string
		add_column :users, :hair, :string
		add_column :users, :hair_style, :string
		add_column :users, :citizenship, :string
		add_column :users, :ethnicity, :string
		add_column :users, :language_level, :string
		add_column :users, :wedding_opinion, :string
		add_column :users, :music_genre, :string
		add_column :users, :cinema_frequency, :string
		add_column :users, :cinema_genre, :string
		add_column :users, :like_sport, :string
		add_column :users, :like_read, :string
		add_column :users, :like_cinema, :string
		add_column :users, :like_quiet, :string
		add_column :users, :like_walk, :string
		add_column :users, :like_mountain, :string
		add_column :users, :like_beach, :string
		add_column :users, :like_family, :string
		add_column :users, :like_friends, :string
		add_column :users, :religion_activity, :string
		rename_column :users, :animal_like, :animals
		remove_column :users, :child_want
		remove_column :users, :smoke_tolerance
		remove_column :users, :religion_opinion
		remove_column :users, :drugs
    remove_column :users, :drug_frequency
    remove_column :users, :animal_have
    remove_column :users, :hobbies
  end

  def down
  	remove_column :users, :house
		remove_column :users, :eyes
		remove_column :users, :hair
		remove_column :users, :hair_style
		remove_column :users, :citizenship
		remove_column :users, :ethnicity
		remove_column :users, :language_level
		remove_column :users, :wedding_opinion
		remove_column :users, :music_genre
		remove_column :users, :cinema_frequency
		remove_column :users, :cinema_genre
		remove_column :users, :like_sport
		remove_column :users, :like_read
		remove_column :users, :like_cinema
		remove_column :users, :like_quiet
		remove_column :users, :like_walk
		remove_column :users, :like_mountain
		remove_column :users, :like_beach
		remove_column :users, :like_family
		remove_column :users, :like_friends
		remove_column :users, :religion_activity
		rename_column :users, :animals, :animal_like
		add_column :users, :child_want, :string
		add_column :users, :smoke_tolerance, :string
		add_column :users, :religion_opinion, :string
		add_column :users, :drugs, :string
    add_column :users, :drug_frequency, :string
    add_column :users, :animal_have, :string
    add_column :users, :hobbies, :string
  end
end
