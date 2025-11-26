require "test_helper"

class Administrator::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrator_post_comments_index_url
    assert_response :success
  end
end
