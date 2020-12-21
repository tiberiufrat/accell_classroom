class DriveFilesController < ApplicationController
  before_action :set_drive_file, only: %i[ show edit update destroy ]

  def index
    @search = DriveFile.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @drive_files = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @drive_file
  end

  def new
    @drive_file = DriveFile.new
  end

  def edit
  end

  def create
    @drive_file = DriveFile.new(drive_file_params)
    @drive_file.save!

    respond_to do |format|
      format.html { redirect_to @drive_file, notice: 'Drive file was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @drive_file.update!(drive_file_params)
    respond_to do |format|
      format.html { redirect_to @drive_file, notice: 'Drive file was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @drive_file.destroy
    respond_to do |format|
      format.html { redirect_to drive_files_url, notice: 'Drive file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_drive_file
      @drive_file = DriveFile.find(params[:id])
    end

    def drive_file_params
      params.require(:drive_file).permit(:classroom_id, :title, :link, :thumbnail)
    end
end
