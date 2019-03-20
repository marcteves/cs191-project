require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "admin user view index" do
		admin_user = users(:admin_user)
		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }
		get '/users'
		assert_response :success
	end

	test "admin verify toggle user" do
		admin_user = users(:admin_user)
		unverified_user = users(:unverified_user)

		assert_changes 'User.find_by(id: unverified_user.id).verified?',
			from: false, to: true do

			post login_path, params: { session: { email: admin_user.email,
												 password: 'password' } }
			post verify_path, params: { user_id: unverified_user.id }
			assert_response :success

		end

	end

	test "regular user view index" do
		regular_user = users(:regular_user)
		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }
		get '/users'
		assert_response 422
	end

	# both tests are identical for now, but some elements should be hidden
	# for regular user view
	test "admin view other user" do
		admin_user = users(:admin_user)
		regular_user = users(:regular_user)

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }

		get user_view_path(regular_user.id)
		assert_response :success
	end

	test "regular user view other user" do
		regular_user_A = users(:regular_user)
		regular_user_B = users(:unverified_user)

		post login_path, params: { session: { email: regular_user_A.email,
											 password: 'password' } }

		get user_view_path(regular_user_B.id)
		assert_response :success
	end

	test "admin view non-existent user" do
		admin_user = users(:admin_user)

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }

		get user_view_path(1)
		assert_response :missing
	end

	test "user view edit page" do
		regular_user = users(:regular_user)

		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }

		get user_view_edit_path(regular_user.id)
		assert_response :success
	end

	test "user edit self" do
		regular_user = users(:regular_user)

		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }

		assert_changes 'User.find_by(id: regular_user.id).name',
			from: 'One', to: 'Juan Dela Cruz' do
			patch user_edit_path(regular_user.id),
				params: { user: { name: "Juan Dela Cruz" } }
			assert_response :success
		end

	end



	# user disables self via the existing user_edit path
	test "user disable self" do
		regular_user = users(:regular_user)

		post login_path, params: { session: { email: regular_user.email,
											 password: 'password' } }

		assert_changes 'User.find_by(id: regular_user.id).enabled',
			from: true, to: false do
			patch user_edit_path(regular_user.id),
				params: { user: { enabled: "1" } }
			assert_response :success
		end
	end

	# admin disables user via disable path
	# NOTE: database is reset for every test, so for this test
	# forget what happened in "user disable self"
	test "admin enable disabled user" do
		admin_user = users(:admin_user)
		disabled_user = users(:disabled_user)

		post login_path, params: { session: { email: admin_user.email,
											 password: 'password' } }

		assert_changes 'User.find_by(id: disabled_user.id).enabled',
			from: false, to: true do
			patch user_disable_path(disabled_user.id)
			assert_response :success
		end
	end


end
