ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "devise/jwt/test_helpers"

module ActiveSupport
  class TestCase
    setup do
      user = users(:admin)
      headers = { "Accept" => "application/json", "Content-Type" => "application/json" }
      # This will add a valid token for `user` in the `Authorization` header
      @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    end
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
