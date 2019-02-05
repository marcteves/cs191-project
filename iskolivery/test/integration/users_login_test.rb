require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def access_login_page
		get login_path
		assert_response :success
	end

	test "login with invalid info" do
		access_login_page
		post login_path, params: { email: "", password: "" }
		assert_response :redirect
	end

	test "login with valid info" do
		access_login_page
	end
end
