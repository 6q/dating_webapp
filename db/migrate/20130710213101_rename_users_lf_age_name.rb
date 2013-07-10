class RenameUsersLfAgeName < ActiveRecord::Migration
  def up
    rename_column :users, :lf_age_between, :lf_age_from
  end

  def down
    rename_column :users, :lf_age_from, :lf_age_between
  end
end
