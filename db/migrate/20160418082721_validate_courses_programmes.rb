class ValidateCoursesProgrammes < ActiveRecord::Migration
  def change
    add_index :courses_programmes, [:course_id, :programme_id], unique: true
  end
end
