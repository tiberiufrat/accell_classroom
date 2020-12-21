class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  def index
    @search = Link.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @links = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @link
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params)
    @link.save!

    respond_to do |format|
      format.html { redirect_to @link, notice: 'Link was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @link.update!(link_params)
    respond_to do |format|
      format.html { redirect_to @link, notice: 'Link was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:url, :titile, :thumbnail)
    end
end
