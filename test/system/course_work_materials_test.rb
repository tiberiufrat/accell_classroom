require "application_system_test_case"

class CourseWorkMaterialsTest < ApplicationSystemTestCase
  setup do
    @course_work_material = course_work_materials(:one)
  end

  test "visiting the index" do
    visit course_work_materials_url
    assert_selector "h1", text: "Course Work Materials"
  end

  test "creating a Course work material" do
    visit course_work_materials_url
    click_on "New Course Work Material"

    check_label "course_work_material_all_students" if @course_work_material.all_students
    fill_in "Classroom", with: @course_work_material.classroom_id
    fill_in "Course", with: @course_work_material.course_id
    fill_in "Creation time", with: @course_work_material.creation_time
    fill_in "Description", with: @course_work_material.description
    fill_in "Materials", with: @course_work_material.materials
    fill_in "Title", with: @course_work_material.title
    click_on "Create Course work material"

    assert_text "Course work material was successfully created."
    click_on "Back"
  end

  test "updating a Course work material" do
    visit course_work_materials_url
    click_on "Edit it", match: :first

    check_label "course_work_material_all_students" if @course_work_material.all_students
    fill_in "Classroom", with: @course_work_material.classroom_id
    fill_in "Course", with: @course_work_material.course_id
    fill_in "Creation time", with: @course_work_material.creation_time
    fill_in "Description", with: @course_work_material.description
    fill_in "Materials", with: @course_work_material.materials
    fill_in "Title", with: @course_work_material.title
    click_on "Update Course work material"

    assert_text "Course work material was successfully updated."
    click_on "Back"
  end

  test "destroying a Course work material" do
    visit course_work_materials_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Course work material was successfully destroyed."
  end
end
