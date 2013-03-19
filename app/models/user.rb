class User < ActiveRecord::Base
  GENDER = ['male', 'female']
  ORIENTATION = ['straight', 'homo', 'bi']
  MARITAL_STATUS = ['casado', 'soltero', 'viudo']
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :surname, :screen_name, :gender, :orientation, :marital_status, :birth_date, :country, :zip_code, :town, :town_id, :newsletter_optin
end
