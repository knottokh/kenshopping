require 'test_helper'

class Spree::SearchOrderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spree_search_order_index_url
    assert_response :success
  end

end
