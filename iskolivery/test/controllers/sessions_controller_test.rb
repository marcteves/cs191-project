require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:regular_user)
	end
  test "root should route to login page" do
    get root_path
	assert_template 'sessions/new'
  end

  test "login with invalid info" do
	  visit_login_page
	  post login_path, params: { session: { email: '', password: '' } }
	  assert_template 'sessions/new'
  end

  test "login with valid info" do
	  visit_login_page
	  setup
	  post login_path, params: { session: { email: @user.email,
										 password: 'password' } }
	  assert_redirected_to home_path
  end

  test "visiting login after already logged in" do
  end

  private
	  def visit_login_page
		get login_path
		assert_template 'sessions/new'
	  end

end
