class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
