class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :description
      t.string :address
      t.integer :classes

      t.timestamps
    end
  end
end
