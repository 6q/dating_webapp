module DatePresenter
  def present(attr_name)
    %w(day month year).each do |f|
      partial_name = :"#{attr_name}_#{f}"
      attr_writer partial_name
      attr_accessible partial_name

      define_method(name) do
        date = self[:name]
        date.send(f) if date
      end
    end
  end
end

class User < ActiveRecord::Base
  include DatePresenter
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
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :surname, :screen_name, :gender, :orientation, :marital_status,
    :birth_date, :country, :zip_code, :town, :town_id, :newsletter_optin
end
