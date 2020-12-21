require "test_helper"

class YoutubeVideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @youtube_video = youtube_videos(:one)
  end

  test "should get index" do
    get youtube_videos_url
    assert_response :success
  end

  test "should get new" do
    get new_youtube_video_url
    assert_response :success
  end

  test "should create youtube_video" do
    assert_difference('YoutubeVideo.count') do
      post youtube_videos_url, params: { youtube_video: { classroom_id: @youtube_video.classroom_id, link: @youtube_video.link, thumbnail: @youtube_video.thumbnail, title: @youtube_video.title } }
    end

    assert_redirected_to youtube_video_url(YoutubeVideo.last)
  end

  test "should show youtube_video" do
    get youtube_video_url(@youtube_video)
    assert_response :success
  end

  test "should get edit" do
    get edit_youtube_video_url(@youtube_video)
    assert_response :success
  end

  test "should update youtube_video" do
    patch youtube_video_url(@youtube_video), params: { youtube_video: { classroom_id: @youtube_video.classroom_id, link: @youtube_video.link, thumbnail: @youtube_video.thumbnail, title: @youtube_video.title } }
    assert_redirected_to youtube_video_url(@youtube_video)
  end

  test "should destroy youtube_video" do
    assert_difference('YoutubeVideo.count', -1) do
      delete youtube_video_url(@youtube_video)
    end

    assert_redirected_to youtube_videos_url
  end
end
