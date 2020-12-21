require "application_system_test_case"

class FormsTest < ApplicationSystemTestCase
  setup do
    @form = forms(:one)
  end

  test "visiting the index" do
    visit forms_url
    assert_selector "h1", text: "Forms"
  end

  test "creating a Form" do
    visit forms_url
    click_on "New Form"

    fill_in "Response url", with: @form.response_url
    fill_in "Thumbnail", with: @form.thumbnail
    fill_in "Title", with: @form.title
    fill_in "Url", with: @form.url
    click_on "Create Form"

    assert_text "Form was successfully created."
    click_on "Back"
  end

  test "updating a Form" do
    visit forms_url
    click_on "Edit it", match: :first

    fill_in "Response url", with: @form.response_url
    fill_in "Thumbnail", with: @form.thumbnail
    fill_in "Title", with: @form.title
    fill_in "Url", with: @form.url
    click_on "Update Form"

    assert_text "Form was successfully updated."
    click_on "Back"
  end

  test "destroying a Form" do
    visit forms_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Form was successfully destroyed."
  end
end
