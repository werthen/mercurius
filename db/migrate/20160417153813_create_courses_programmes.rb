class CreateCoursesProgrammes < ActiveRecord::Migration
  def change
    create_table :courses_programmes, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :programme, index: true
    end
  end
end
