require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "admin user view index" do
		admin_user = users(:two)
		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		get '/users'
		assert_response :success
	end

	test "admin verify user" do 
		admin_user = users(:two)
		unverified_user = users(:three)
		assert_equal false, unverified_user.verified

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		post verify_path, params: { user_id: unverified_user.id }

		assert_equal true, unverified_user.verified
	end

	test "admin unverify user" do 
		admin_user = users(:two)
		unverified_user = users(:three)
		assert_equal true, unverified_user.verified

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		post verify_path, params: { user_id: unverified_user.id }

		assert_equal false, unverified_user.verified
	end

	test "regular user view index" do
		regular_user = users(:one)
		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }
		get '/users'
		assert_response 403
	end

end
