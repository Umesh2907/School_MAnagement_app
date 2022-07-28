class StudentsController < ApplicationController
  before_action :set_school

  def index
    @students = @school.students.all
    respond_to do |format|
      format.html
      format.json { render json: StudentDatatable.new(params, view_context: view_context) }
      format.csv { send_data @students.to_csv(['id', 'name', 'gender', 'birth_date', 'roll_no', 'standard', 'email']) }
    end
  end

  def show
    @student = Student.find(params[:id])
  end
  
  def new
    @student = @school.students.new
  end

  def edit
    @student = @school.students.find(params[:id])
  end

  def create
    @student = @school.students.create(student_params)
    if @student.save
    StudentJob.perform_later(@student.id)
    flash[:success] = "Thank you for your registration! We'll get contact you soon!"
    # CrudNotificationMailer.create_notification(@student).deliver_now
    redirect_to school_path(@school)
    else 
      flash.now[:error] = "Your registration form had some errors. Please check the form and resubmit."
      render :new
    end
  end

  def update
    @student = @school.students.find(params[:id])

    if @student.update(student_params)
      CrudNotificationMailer.update_notification(@student).deliver_now
      redirect_to school_students_path
    else
      render 'edit'
    end
  end

  def destroy
    @student = @school.students.find(params[:id])
    CrudNotificationMailer.delete_notification(@student).deliver_now
    @student.destroy
    redirect_to school_students_path(@school)
  end

  private

  def set_school
    @school = School.find_by(id: params[:school_id])
  end
  def student_params
    params.require(:student).permit(:name, :birth_date, :gender, :roll_no, :standard, :email)
  end
end
