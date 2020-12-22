class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]

  def index
    @search = Report.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @reports = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @report
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.save!

    respond_to do |format|
      format.html { redirect_to @report, notice: 'Report was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @report.update!(report_params)
    respond_to do |format|
      format.html { redirect_to @report, notice: 'Report was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @report.activities.destroy_all
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:date_start, :date_end, :user_id)
  end

end
