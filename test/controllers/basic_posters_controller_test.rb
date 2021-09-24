require "test_helper"

class BasicPostersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basic_poster = basic_posters(:one)
  end

  test "should get index" do
    get basic_posters_url, as: :json
    assert_response :success
  end

  test "should create basic_poster" do
    assert_difference('BasicPoster.count') do
      post basic_posters_url, params: { basic_poster: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show basic_poster" do
    get basic_poster_url(@basic_poster), as: :json
    assert_response :success
  end

  test "should update basic_poster" do
    patch basic_poster_url(@basic_poster), params: { basic_poster: {  } }, as: :json
    assert_response 200
  end

  test "should destroy basic_poster" do
    assert_difference('BasicPoster.count', -1) do
      delete basic_poster_url(@basic_poster), as: :json
    end

    assert_response 204
  end
end
