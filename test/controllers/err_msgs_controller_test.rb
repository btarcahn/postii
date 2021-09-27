require "test_helper"

class ErrMsgsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @err_msg = err_msgs(:one)
  end

  test "should get index" do
    get err_msgs_url, as: :json
    assert_response :success
  end

  test "should create err_msg" do
    assert_difference('ErrMsg.count') do
      post err_msgs_url, headers: { "Authorization" => @token },
           params: { err_msg: {
             err_code: "TEST0000",
             message: "a test error message",
             reason: "nothing went wrong",
             component: 'core',
             additional_note: 'nothing'
           } }, as: :json
    end

    assert_response 201
  end

  test "should show err_msg" do
    get err_msg_url(@err_msg), as: :json
    assert_response :success
  end

  test "should update err_msg" do
    patch err_msg_url(@err_msg), params: { err_msg: {  } }, as: :json
    assert_response 200
  end

  test "should destroy err_msg" do
    assert_difference('ErrMsg.count', -1) do
      delete err_msg_url(@err_msg), as: :json
    end

    assert_response 204
  end
end
