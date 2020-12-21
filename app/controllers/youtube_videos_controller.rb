class YoutubeVideosController < ApplicationController
  before_action :set_youtube_video, only: %i[ show edit update destroy ]

  def index
    @search = YoutubeVideo.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @youtube_videos = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @youtube_video
  end

  def new
    @youtube_video = YoutubeVideo.new
  end

  def edit
  end

  def create
    @youtube_video = YoutubeVideo.new(youtube_video_params)
    @youtube_video.save!

    respond_to do |format|
      format.html { redirect_to @youtube_video, notice: 'Youtube video was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @youtube_video.update!(youtube_video_params)
    respond_to do |format|
      format.html { redirect_to @youtube_video, notice: 'Youtube video was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @youtube_video.destroy
    respond_to do |format|
      format.html { redirect_to youtube_videos_url, notice: 'Youtube video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_youtube_video
      @youtube_video = YoutubeVideo.find(params[:id])
    end

    def youtube_video_params
      params.require(:youtube_video).permit(:classroom_id, :title, :link, :thumbnail)
    end
end
