require "test_helper"

class CourseWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_work = course_works(:one)
  end

  test "should get index" do
    get course_works_url
    assert_response :success
  end

  test "should get new" do
    get new_course_work_url
    assert_response :success
  end

  test "should create course_work" do
    assert_difference('CourseWork.count') do
      post course_works_url, params: { course_work: { all_students: @course_work.all_students, classroom_id: @course_work.classroom_id, course_id: @course_work.course_id, creation_time: @course_work.creation_time, description: @course_work.description, due_date: @course_work.due_date, materials: @course_work.materials, title: @course_work.title, work_type: @course_work.work_type } }
    end

    assert_redirected_to course_work_url(CourseWork.last)
  end

  test "should show course_work" do
    get course_work_url(@course_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_work_url(@course_work)
    assert_response :success
  end

  test "should update course_work" do
    patch course_work_url(@course_work), params: { course_work: { all_students: @course_work.all_students, classroom_id: @course_work.classroom_id, course_id: @course_work.course_id, creation_time: @course_work.creation_time, description: @course_work.description, due_date: @course_work.due_date, materials: @course_work.materials, title: @course_work.title, work_type: @course_work.work_type } }
    assert_redirected_to course_work_url(@course_work)
  end

  test "should destroy course_work" do
    assert_difference('CourseWork.count', -1) do
      delete course_work_url(@course_work)
    end

    assert_redirected_to course_works_url
  end
end
