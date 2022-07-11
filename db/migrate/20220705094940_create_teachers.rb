class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.date :birth_date
      t.string :gender
      t.string :email
      t.string :subject
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
