require "application_system_test_case"

class CourseWorksTest < ApplicationSystemTestCase
  setup do
    @course_work = course_works(:one)
  end

  test "visiting the index" do
    visit course_works_url
    assert_selector "h1", text: "Course Works"
  end

  test "creating a Course work" do
    visit course_works_url
    click_on "New Course Work"

    check_label "course_work_all_students" if @course_work.all_students
    fill_in "Classroom", with: @course_work.classroom_id
    fill_in "Course", with: @course_work.course_id
    fill_in "Creation time", with: @course_work.creation_time
    fill_in "Description", with: @course_work.description
    fill_in "Due date", with: @course_work.due_date
    fill_in "Materials", with: @course_work.materials
    fill_in "Title", with: @course_work.title
    fill_in "Work type", with: @course_work.work_type
    click_on "Create Course work"

    assert_text "Course work was successfully created."
    click_on "Back"
  end

  test "updating a Course work" do
    visit course_works_url
    click_on "Edit it", match: :first

    check_label "course_work_all_students" if @course_work.all_students
    fill_in "Classroom", with: @course_work.classroom_id
    fill_in "Course", with: @course_work.course_id
    fill_in "Creation time", with: @course_work.creation_time
    fill_in "Description", with: @course_work.description
    fill_in "Due date", with: @course_work.due_date
    fill_in "Materials", with: @course_work.materials
    fill_in "Title", with: @course_work.title
    fill_in "Work type", with: @course_work.work_type
    click_on "Update Course work"

    assert_text "Course work was successfully updated."
    click_on "Back"
  end

  test "destroying a Course work" do
    visit course_works_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Course work was successfully destroyed."
  end
end
