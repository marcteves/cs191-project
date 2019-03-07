require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "admin user view index" do
		admin_user = users(:two)
		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		get '/users'
		assert_response :success
	end

	test "admin verify toggle user" do 
		admin_user = users(:two)
		unverified_user = users(:three)

		assert_changes 'User.find_by(id: unverified_user.id).verified?',
			from: false, to: true do

			post login_path, params: { session: { email: admin_user.email,
												 password: 'password' } }
			post verify_path, params: { user_id: unverified_user.id }
			assert_response :success

		end

	end

	test "regular user view index" do
		regular_user = users(:one)
		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }
		get '/users'
		assert_response 422
	end

	# both tests are identical for now, but some elements should be hidden
	# for regular user view
	test "admin view other user" do
		admin_user = users(:two)
		regular_user = users(:one)

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }

		get "/users/#{regular_user.id}"
		assert_response :success
	end

	test "regular user view other user" do
		regular_user_A = users(:one)
		regular_user_B = users(:three)

		post login_path, params: { session: { email: regular_user_A.email,
											 password: 'password' } }

		get "/users/#{regular_user_B.id}"
		assert_response :success
	end


end
