# Cellove
========================

This application was generated with the rails_apps_composer gem:
https://github.com/RailsApps/rails_apps_composer
provided by the RailsApps Project:
http://railsapps.github.com/

________________________

Recipes:
["controllers", "core", "email", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "saas", "setup", "testing", "views"]

Preferences:
{:git=>true, :railsapps=>"none", :dev_webserver=>"unicorn", :prod_webserver=>"unicorn", :database=>"postgresql", :templates=>"erb", :unit_test=>"test_unit", :integration=>"minitest-capybara", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"mandrill", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :form_builder=>"simple_form", :starter_app=>"admin_app", :rvmrc=>false, :quiet_assets=>true, :local_env_file=>true, :better_errors=>true, :ban_spiders=>true}

________________________

# Deploy static site to Heroku

Install latest Git from homebrew

	brew update
	brew install git

Deploy:

	git subtree push --prefix prototype

