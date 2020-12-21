require "application_system_test_case"

class YoutubeVideosTest < ApplicationSystemTestCase
  setup do
    @youtube_video = youtube_videos(:one)
  end

  test "visiting the index" do
    visit youtube_videos_url
    assert_selector "h1", text: "Youtube Videos"
  end

  test "creating a Youtube video" do
    visit youtube_videos_url
    click_on "New Youtube Video"

    fill_in "Classroom", with: @youtube_video.classroom_id
    fill_in "Link", with: @youtube_video.link
    fill_in "Thumbnail", with: @youtube_video.thumbnail
    fill_in "Title", with: @youtube_video.title
    click_on "Create Youtube video"

    assert_text "Youtube video was successfully created."
    click_on "Back"
  end

  test "updating a Youtube video" do
    visit youtube_videos_url
    click_on "Edit it", match: :first

    fill_in "Classroom", with: @youtube_video.classroom_id
    fill_in "Link", with: @youtube_video.link
    fill_in "Thumbnail", with: @youtube_video.thumbnail
    fill_in "Title", with: @youtube_video.title
    click_on "Update Youtube video"

    assert_text "Youtube video was successfully updated."
    click_on "Back"
  end

  test "destroying a Youtube video" do
    visit youtube_videos_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Youtube video was successfully destroyed."
  end
end
