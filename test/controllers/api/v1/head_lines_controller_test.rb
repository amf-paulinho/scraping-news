require "test_helper"

class Api::V1::HeadLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_head_lines_index_url
    assert_response :success
  end
end
