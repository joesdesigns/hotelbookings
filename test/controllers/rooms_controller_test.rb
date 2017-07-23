require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get book" do
    get rooms_book_url
    assert_response :success
  end

  test "should get list" do
    get rooms_list_url
    assert_response :success
  end

  test "should get list_available" do
    get rooms_list_available_url
    assert_response :success
  end

  test "should get cleaning_schedule" do
    get rooms_cleaning_schedule_url
    assert_response :success
  end

end
