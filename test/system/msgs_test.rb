require "application_system_test_case"

class MsgsTest < ApplicationSystemTestCase
  setup do
    @msg = msgs(:one)
  end

  test "visiting the index" do
    visit msgs_url
    assert_selector "h1", text: "Msgs"
  end

  test "creating a Msg" do
    visit msgs_url
    click_on "New Msg"

    fill_in "Description", with: @msg.description
    fill_in "Name", with: @msg.name
    click_on "Create Msg"

    assert_text "Msg was successfully created"
    click_on "Back"
  end

  test "updating a Msg" do
    visit msgs_url
    click_on "Edit", match: :first

    fill_in "Description", with: @msg.description
    fill_in "Name", with: @msg.name
    click_on "Update Msg"

    assert_text "Msg was successfully updated"
    click_on "Back"
  end

  test "destroying a Msg" do
    visit msgs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Msg was successfully destroyed"
  end
end
