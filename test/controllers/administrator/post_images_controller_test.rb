require "test_helper"

class Administrator::PostImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrator_post_images_index_url
    assert_response :success
  end
end
