class CourseWorkMaterialsController < ApplicationController
  before_action :set_course_work_material, only: %i[ show edit update destroy ]

  def index
    @search = CourseWorkMaterial.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @course_work_materials = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @course_work_material
  end

  def new
    @course_work_material = CourseWorkMaterial.new
  end

  def edit
  end

  def create
    @course_work_material = CourseWorkMaterial.new(course_work_material_params)
    @course_work_material.save!

    respond_to do |format|
      format.html { redirect_to @course_work_material, notice: 'Course work material was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @course_work_material.update!(course_work_material_params)
    respond_to do |format|
      format.html { redirect_to @course_work_material, notice: 'Course work material was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @course_work_material.destroy
    respond_to do |format|
      format.html { redirect_to course_work_materials_url, notice: 'Course work material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course_work_material
      @course_work_material = CourseWorkMaterial.find(params[:id])
    end

    def course_work_material_params
      params.require(:course_work_material).permit(:classroom_id, :title, :description, :materials, :creation_time, :all_students, :course_id)
    end
end
