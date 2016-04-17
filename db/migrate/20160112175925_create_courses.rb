class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :semester
      t.references :lecturer, index: true
      t.integer :studyhours
      t.integer :credits
      t.string :code

      t.timestamps null: false
    end
    add_foreign_key :courses, :lecturers
  end
end
