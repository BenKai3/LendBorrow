require 'test_helper'

class LendersControllerTest < ActionController::TestCase
  setup do
    @lender = lenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lender" do
    assert_difference('Lender.count') do
      post :create, lender: { created_at: @lender.created_at, email: @lender.email, encrypted_password: @lender.encrypted_password, first_name: @lender.first_name, last_name: @lender.last_name, money: @lender.money, salt: @lender.salt, updated_at: @lender.updated_at }
    end

    assert_redirected_to lender_path(assigns(:lender))
  end

  test "should show lender" do
    get :show, id: @lender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lender
    assert_response :success
  end

  test "should update lender" do
    patch :update, id: @lender, lender: { created_at: @lender.created_at, email: @lender.email, encrypted_password: @lender.encrypted_password, first_name: @lender.first_name, last_name: @lender.last_name, money: @lender.money, salt: @lender.salt, updated_at: @lender.updated_at }
    assert_redirected_to lender_path(assigns(:lender))
  end

  test "should destroy lender" do
    assert_difference('Lender.count', -1) do
      delete :destroy, id: @lender
    end

    assert_redirected_to lenders_path
  end
end
