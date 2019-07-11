require "application_system_test_case"

class MultiplepostsTest < ApplicationSystemTestCase
  setup do
    @multiplepost = multipleposts(:one)
  end

  test "visiting the index" do
    visit multipleposts_url
    assert_selector "h1", text: "Multipleposts"
  end

  test "creating a Multiplepost" do
    visit multipleposts_url
    click_on "New Multiplepost"

    fill_in "Article", with: @multiplepost.article
    fill_in "Attchment", with: @multiplepost.attchment
    click_on "Create Multiplepost"

    assert_text "Multiplepost was successfully created"
    click_on "Back"
  end

  test "updating a Multiplepost" do
    visit multipleposts_url
    click_on "Edit", match: :first

    fill_in "Article", with: @multiplepost.article
    fill_in "Attchment", with: @multiplepost.attchment
    click_on "Update Multiplepost"

    assert_text "Multiplepost was successfully updated"
    click_on "Back"
  end

  test "destroying a Multiplepost" do
    visit multipleposts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Multiplepost was successfully destroyed"
  end
end
