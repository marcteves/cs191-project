require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "admin user view index" do
		admin_user = users(:two)
		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		get '/users'
		assert_response :success
	end

	test "regular user view index" do
		regular_user = users(:one)
		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }
		get '/users'
		assert_response 403
	end

end
