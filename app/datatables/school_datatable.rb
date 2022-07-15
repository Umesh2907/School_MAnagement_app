class SchoolDatatable < AjaxDatatablesRails::ActiveRecord
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
      school_name:{ source: "School.school_name" },
      description:{ source: "School.description" },
      address:    { source: "School.address" },
      classes:    { source: "School.classes" },
    }
  end


  def data
    records.map do |record|
      # byebug
      {
        school_name: link_to(record.school_name, record),
        description: record.description,
        address:     record.address,
        classes:     record.classes,
      }
    end
  end

  def get_raw_records
    # insert query here
    @schools = School.all
  end

end
