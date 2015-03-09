require 'test_helper'

class BorrowersControllerTest < ActionController::TestCase
  setup do
    @borrower = borrowers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:borrowers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create borrower" do
    assert_difference('Borrower.count') do
      post :create, borrower: { created_at: @borrower.created_at, description: @borrower.description, email: @borrower.email, encrypted_password: @borrower.encrypted_password, first_name: @borrower.first_name, last_name: @borrower.last_name, money: @borrower.money, purpose: @borrower.purpose, raised: @borrower.raised, salt: @borrower.salt, updated_at: @borrower.updated_at }
    end

    assert_redirected_to borrower_path(assigns(:borrower))
  end

  test "should show borrower" do
    get :show, id: @borrower
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @borrower
    assert_response :success
  end

  test "should update borrower" do
    patch :update, id: @borrower, borrower: { created_at: @borrower.created_at, description: @borrower.description, email: @borrower.email, encrypted_password: @borrower.encrypted_password, first_name: @borrower.first_name, last_name: @borrower.last_name, money: @borrower.money, purpose: @borrower.purpose, raised: @borrower.raised, salt: @borrower.salt, updated_at: @borrower.updated_at }
    assert_redirected_to borrower_path(assigns(:borrower))
  end

  test "should destroy borrower" do
    assert_difference('Borrower.count', -1) do
      delete :destroy, id: @borrower
    end

    assert_redirected_to borrowers_path
  end
end
