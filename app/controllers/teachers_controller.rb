class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end
  
  def new
    set_school
    @teacher = @school.teachers.new
  end

  def edit
    set_school
    @teacher = @school.teachers.find(params[:id])
  end

  def create
    set_school
    @teacher = @school.teachers.create(teacher_params)

    redirect_to school_path(@school)
    # @teacher = Teacher.new(teacher_params)

    # if @teacher.save(teacher_params)
    #   redirect_to @teacher
    # else
    #   render 'new'
    # end
  end

  def update
    @teacher = Teacher.find(params[:id])

    if @teacher.update(teacher_params)
      redirect_to @teacher
    else
      render 'edit'
    end
  end

  def destroy
    set_school
    @teacher = @school.teachers.find(params[:id])
    @teacher.destroy

    redirect_to school_path(@school)
  end

  private
  def set_school
    @school = School.find_by(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name, :birth_date, :gender, :email, :subject, :school_id)
  end
end
