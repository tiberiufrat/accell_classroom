require "test_helper"

class DriveFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drive_file = drive_files(:one)
  end

  test "should get index" do
    get drive_files_url
    assert_response :success
  end

  test "should get new" do
    get new_drive_file_url
    assert_response :success
  end

  test "should create drive_file" do
    assert_difference('DriveFile.count') do
      post drive_files_url, params: { drive_file: { classroom_id: @drive_file.classroom_id, link: @drive_file.link, thumbnail: @drive_file.thumbnail, title: @drive_file.title } }
    end

    assert_redirected_to drive_file_url(DriveFile.last)
  end

  test "should show drive_file" do
    get drive_file_url(@drive_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_drive_file_url(@drive_file)
    assert_response :success
  end

  test "should update drive_file" do
    patch drive_file_url(@drive_file), params: { drive_file: { classroom_id: @drive_file.classroom_id, link: @drive_file.link, thumbnail: @drive_file.thumbnail, title: @drive_file.title } }
    assert_redirected_to drive_file_url(@drive_file)
  end

  test "should destroy drive_file" do
    assert_difference('DriveFile.count', -1) do
      delete drive_file_url(@drive_file)
    end

    assert_redirected_to drive_files_url
  end
end
