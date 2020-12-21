require "application_system_test_case"

class AnnouncementsTest < ApplicationSystemTestCase
  setup do
    @announcement = announcements(:one)
  end

  test "visiting the index" do
    visit announcements_url
    assert_selector "h1", text: "Announcements"
  end

  test "creating a Announcement" do
    visit announcements_url
    click_on "New Announcement"

    check_label "announcement_all_students" if @announcement.all_students
    fill_in "Classroom", with: @announcement.classroom_id
    fill_in "Course", with: @announcement.course_id
    fill_in "Creation time", with: @announcement.creation_time
    fill_in "Materials", with: @announcement.materials
    fill_in "Text", with: @announcement.text
    click_on "Create Announcement"

    assert_text "Announcement was successfully created."
    click_on "Back"
  end

  test "updating a Announcement" do
    visit announcements_url
    click_on "Edit it", match: :first

    check_label "announcement_all_students" if @announcement.all_students
    fill_in "Classroom", with: @announcement.classroom_id
    fill_in "Course", with: @announcement.course_id
    fill_in "Creation time", with: @announcement.creation_time
    fill_in "Materials", with: @announcement.materials
    fill_in "Text", with: @announcement.text
    click_on "Update Announcement"

    assert_text "Announcement was successfully updated."
    click_on "Back"
  end

  test "destroying a Announcement" do
    visit announcements_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Announcement was successfully destroyed."
  end
end
