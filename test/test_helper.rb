ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def simply_login
    email = 'test@postii.com'
    password = 'mHYk5+@*n9G.Frfd'

    post '/auth/sign_in', params: { user: { email: email, password: password } }, as: :json
    puts response.body
    if response.code == '422' && response.body['err_code'] == 'ERR00006'
      post 'auth/sign_up', params: { user: { email: email, password: password, password_confirmation: password } }
      assert_equal '200', response.code, 'Cannot register a test account'
      post '/auth/sign_in', params: { user: { email: email, password: password } }
      puts response.body['token']
      return response.body['token']
    end
    assert_equal '200', response.code, 'Something went wrong with the login part.'
    response.body['token']
  end

  def setup_test_environment
    Rake::Task['db:seed_err_msg'].invoke if ErrMsg.count <= 1
  end
end
