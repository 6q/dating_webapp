source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'mysql2'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails', "~> 2.2.1"
gem "unicorn", ">= 4.3.1"
gem "bootstrap-sass", ">= 2.3.0.0"
gem "hominid", ">= 3.0.5"
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.9"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.1.0"
gem "quiet_assets", ">= 1.0.2", :group => :development
gem "figaro", ">= 0.6.3"
gem 'compass_twitter_bootstrap'
gem 'compass-rails'
gem "geocoder", "~> 1.1.3"
gem 'friendly_id'
gem 'dragonfly', '~>0.9.14'
gem 'country_select'
gem 'kaminari'
#gem 'turbolinks'
gem 'mail_form'
gem 'rails-i18n'
gem 'strong_parameters'
gem 'mailboxer'
gem 'gettext_i18n_rails'
gem 'gettext', '>=1.9.3', :require => false, :group => :development
gem 'ransack'
gem 'faker'
gem 'factory_girl_rails', '>= 4.2.0'

group :test do
  gem 'sqlite3'
  gem 'database_cleaner'
  gem 'minitest-focus'
  gem 'minitest-reporters'
end

gem 'minitest-rails', group: [:test, :development]
gem "mail_view", "~> 1.0.3", group: [:test, :development]

group :development do
  gem "guard-rails"
  gem "rb-fsevent"
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
end

group :test, :development do
  gem 'commands'
  #gem 'rack-proxy', git: 'git://github.com/sportngin/rack-proxy.git'
  #gem "rack-reverse-proxy", :require => "rack/reverse_proxy", git: 'git://github.com/sportngin/rack-reverse-proxy.git'
end
