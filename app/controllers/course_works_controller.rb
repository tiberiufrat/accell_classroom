class CourseWorksController < ApplicationController
  before_action :set_course_work, only: %i[ show edit update destroy ]

  def index
    @search = CourseWork.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @course_works = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @course_work
  end

  def new
    @course_work = CourseWork.new
  end

  def edit
  end

  def create
    @course_work = CourseWork.new(course_work_params)
    @course_work.save!

    respond_to do |format|
      format.html { redirect_to @course_work, notice: 'Course work was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @course_work.update!(course_work_params)
    respond_to do |format|
      format.html { redirect_to @course_work, notice: 'Course work was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @course_work.destroy
    respond_to do |format|
      format.html { redirect_to course_works_url, notice: 'Course work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course_work
      @course_work = CourseWork.find(params[:id])
    end

    def course_work_params
      params.require(:course_work).permit(:classroom_id, :title, :description, :materials, :creation_time, :due_date, :work_type, :all_students, :course_id)
    end
end
