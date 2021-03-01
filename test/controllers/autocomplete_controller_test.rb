require 'test_helper'

class AutocompleteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get autocomplete_index_url
    assert_response :success
  end

end
