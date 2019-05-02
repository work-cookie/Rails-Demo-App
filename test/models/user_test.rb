require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  def setup
    @user = User.new(name:"Example User", email: "example_user@gmail.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid" do
    valid_emails = %w[user@example.com USER@foo.COM A-US_ER@foo.bar.org first.last+ff@fjp.foo]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid? , "#{valid_email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid? , "#{invalid_email.inspect} should not be valid"
    end
  end

  #Uniqueness always checks with DB records but not with in memory records
  # save the record before check
  test "email address should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?

    dup_user.email = @user.email.upcase
    assert_not dup_user.valid?
  end

  test "email address should be saved in lowercase" do
    mixed_email = "hi_USER_Email@gmail.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " "* 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = " "* 5
    assert_not @user.valid?
  end

end
