require 'test_helper'

class MultiplepostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiplepost = multipleposts(:one)
  end

  test "should get index" do
    get multipleposts_url
    assert_response :success
  end

  test "should get new" do
    get new_multiplepost_url
    assert_response :success
  end

  test "should create multiplepost" do
    assert_difference('Multiplepost.count') do
      post multipleposts_url, params: { multiplepost: { article: @multiplepost.article, attchment: @multiplepost.attchment } }
    end

    assert_redirected_to multiplepost_url(Multiplepost.last)
  end

  test "should show multiplepost" do
    get multiplepost_url(@multiplepost)
    assert_response :success
  end

  test "should get edit" do
    get edit_multiplepost_url(@multiplepost)
    assert_response :success
  end

  test "should update multiplepost" do
    patch multiplepost_url(@multiplepost), params: { multiplepost: { article: @multiplepost.article, attchment: @multiplepost.attchment } }
    assert_redirected_to multiplepost_url(@multiplepost)
  end

  test "should destroy multiplepost" do
    assert_difference('Multiplepost.count', -1) do
      delete multiplepost_url(@multiplepost)
    end

    assert_redirected_to multipleposts_url
  end
end
