ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require 'active_support/testing/assertions'
include ActiveSupport::Testing::Assertions
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

# https://coderwall.com/p/qmgr5q
include FactoryGirl::Syntax::Methods

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

# class MiniTest::Rails::Spec
#   # Add methods to be used by all specs here...

#   def build_message(*args)
#     args[1].gsub(/\?/, '%s') % args[2..-1]
#   end
# end

# class MiniTest::Rails::Controller
#   include ActiveSupport::Testing::SetupAndTeardown
#   include ActionController::TestCase::Behavior
# end
