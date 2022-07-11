class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.date :birth_date
      t.string :gender
      t.integer :roll_no
      t.integer :standard
      t.string :email
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
