class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end
  
  def new
    set_school
    @student = @school.students.new
  end

  def edit
    set_school
    @student = @school.students.find(params[:id])
    # @student = Student.find(params[:id])
  end

  def create
    # @school = School.find(params[:id])
    set_school
    @student = @school.students.create(student_params)

    redirect_to school_path(@school)
    # if @student.save(student_params)
    #   redirect_to @student
    # else
    #   render 'new'
    # end
  end

  def update
    set_school
    @student = @school.student.find(params[:id])

    if @student.update(student_params)
      redirect_to school_students_path
    else
      render 'edit'
    end
  end

  def destroy
    # @school = School.find(params[:school_id])
    set_school
    @student = @school.students.find(params[:id])
    @student.destroy
    redirect_to school_path(@school)


    # @student = Student.find(params[:id])
    # @student.destroy

    # redirect_to school_students_path
  end

  private
  def set_student
    @student = Student.find(id: params[:id])
  end

  def set_school
    @school = School.find_by(params[:id])
  end
  def student_params
    params.require(:student).permit(:name, :birth_date, :gender, :roll_no, :standard, :email)
  end
end
