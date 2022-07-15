class TeachersController < ApplicationController
  before_action :set_school, except: [:show]

  def index
    respond_to do |format|
      format.html
      format.json { render json: TeacherDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end
  
  def new
    @teacher = @school.teachers.new
  end

  def edit
    @teacher = @school.teachers.find_by(id: params[:id])
  end

  def create
    @teacher = @school.teachers.create(teacher_params)

    redirect_to school_path(@school)
  end

  def update
    @teacher = @school.teachers.find(params[:id])

    if @teacher.update(teacher_params)
      redirect_to school_teachers_path
    else
      render 'edit'
    end
  end

  def destroy
    @teacher = @school.teachers.find(params[:id])
    @teacher.destroy
    redirect_to school_path(@school)
  end

  private
  def set_school
    @school = School.find_by(id: params[:school_id])
  end

  def teacher_params
    params.require(:teacher).permit(:name, :birth_date, :gender, :email, :subject)
  end
end
