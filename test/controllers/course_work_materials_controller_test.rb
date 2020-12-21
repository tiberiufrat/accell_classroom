require "test_helper"

class CourseWorkMaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_work_material = course_work_materials(:one)
  end

  test "should get index" do
    get course_work_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_course_work_material_url
    assert_response :success
  end

  test "should create course_work_material" do
    assert_difference('CourseWorkMaterial.count') do
      post course_work_materials_url, params: { course_work_material: { all_students: @course_work_material.all_students, classroom_id: @course_work_material.classroom_id, course_id: @course_work_material.course_id, creation_time: @course_work_material.creation_time, description: @course_work_material.description, materials: @course_work_material.materials, title: @course_work_material.title } }
    end

    assert_redirected_to course_work_material_url(CourseWorkMaterial.last)
  end

  test "should show course_work_material" do
    get course_work_material_url(@course_work_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_work_material_url(@course_work_material)
    assert_response :success
  end

  test "should update course_work_material" do
    patch course_work_material_url(@course_work_material), params: { course_work_material: { all_students: @course_work_material.all_students, classroom_id: @course_work_material.classroom_id, course_id: @course_work_material.course_id, creation_time: @course_work_material.creation_time, description: @course_work_material.description, materials: @course_work_material.materials, title: @course_work_material.title } }
    assert_redirected_to course_work_material_url(@course_work_material)
  end

  test "should destroy course_work_material" do
    assert_difference('CourseWorkMaterial.count', -1) do
      delete course_work_material_url(@course_work_material)
    end

    assert_redirected_to course_work_materials_url
  end
end
