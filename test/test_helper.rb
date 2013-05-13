ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require "minitest/spec"
require "minitest/autorun"
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

MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end
end
 
module MiniTest::Spec::SharedExamples
  def shared_examples_for(desc, &block)
    MiniTest::Spec.shared_examples[desc] = block
  end
 
  def it_behaves_like(desc)
    self.instance_eval(&MiniTest::Spec.shared_examples[desc])
  end
  
  # def it_behaves_like(desc)
  #   self.instance_eval do
  #     MiniTest::Spec.shared_examples[desc].call
  #   end
  # end
end
 
Object.class_eval { include(MiniTest::Spec::SharedExamples) }
