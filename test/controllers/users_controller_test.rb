require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: {
          name: 'lawrence',
          email: 'lawrence@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }, as: :json

      assert_response 201
    end
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }, as: :json

    assert_response 200
  end

  test "should not allow the admin attribute to be edited" do
    assert_not @other_user.admin?

    patch user_path(@other_user), params: {
      user: {
        password: "",
        password_confirmation: "",
        admin: true
      }
    }, as: :json

    assert_not @other_user.reload.admin?
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
