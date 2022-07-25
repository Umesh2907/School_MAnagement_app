class StudentDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id:         { source: "Student.id"},
      name:       { source: "Student.name" },
      birth_date: { source: "Student.birth_date" },
      gender:     { source: "Student.gender" },
      roll_no:    { source: "Student.roll_no" },
      standard:   { source: "Student.standard" },
      email:      { source: "Student.email" },
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        name:       link_to(record.name, "/schools/#{record.school_id}/students/#{record.id}"),
        birth_date: record.birth_date,
        gender:     record.gender,
        roll_no:    record.roll_no,
        standard:   record.standard,
        email:      record.email,
      }
    end
  end

  def get_raw_records
    @school = School.find_by(id: params[:school_id])
    @students = @school.students.all
  end

end
