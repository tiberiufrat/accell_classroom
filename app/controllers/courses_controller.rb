class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  def index
    # @search = Course.reverse_chronologically.ransack(params[:q])
    #
    # respond_to do |format|
    #   format.any(:html, :json) { @courses = set_page_and_extract_portion_from @search.result }
    #   format.csv { render csv: @search.result }
    # end
    @courses = Course.all
  end

  def show
    fresh_when etag: @course
  end

  def new
    @course = Course.where(user: current_user)
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.save!

    respond_to do |format|
      format.html { redirect_to @course, notice: 'Course was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @course.update!(course_params)
    respond_to do |format|
      format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:classroom_id, :name, :section, :description, :creation_time, :enrollment_code, :course_state, :link, :user_id)
    end
end
