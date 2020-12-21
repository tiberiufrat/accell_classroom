require "application_system_test_case"

class DriveFilesTest < ApplicationSystemTestCase
  setup do
    @drive_file = drive_files(:one)
  end

  test "visiting the index" do
    visit drive_files_url
    assert_selector "h1", text: "Drive Files"
  end

  test "creating a Drive file" do
    visit drive_files_url
    click_on "New Drive File"

    fill_in "Classroom", with: @drive_file.classroom_id
    fill_in "Link", with: @drive_file.link
    fill_in "Thumbnail", with: @drive_file.thumbnail
    fill_in "Title", with: @drive_file.title
    click_on "Create Drive file"

    assert_text "Drive file was successfully created."
    click_on "Back"
  end

  test "updating a Drive file" do
    visit drive_files_url
    click_on "Edit it", match: :first

    fill_in "Classroom", with: @drive_file.classroom_id
    fill_in "Link", with: @drive_file.link
    fill_in "Thumbnail", with: @drive_file.thumbnail
    fill_in "Title", with: @drive_file.title
    click_on "Update Drive file"

    assert_text "Drive file was successfully updated."
    click_on "Back"
  end

  test "destroying a Drive file" do
    visit drive_files_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Drive file was successfully destroyed."
  end
end
