require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
          name: "",
          email: "invalid",
          password: "qwer",
          password_confirmation: "fdd" }
      }
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "valid user signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
          name: "1234567",
          email: "valid@gmail.com",
          password: "123456",
          password_confirmation: "123456" }
      }
    end

    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
