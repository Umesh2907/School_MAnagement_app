class TeacherDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name:       { source: "Teacher.name" },
      birth_date: { source: "Teacher.birth_date" },
      gender:     { source: "Teacher.gender" },
      email:      { source: "Teacher.email" },
      subject:    { source: "Teacher.subject" },
    }
  end

  def data
    records.map do |record|
      {
        name:        record.name,
        birth_date:  record.birth_date,
        gender:      record.gender,
        email:       record.email,
        subject:     record.subject,
      }
    end
  end

  def get_raw_records
    # insert query here
    @school = School.find_by(id: params[:school_id])
    @teachers = @school.teachers.all
  end

end
