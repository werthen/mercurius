class AddCodeToLecturers < ActiveRecord::Migration
  def change
    add_column :lecturers, :code, :string
  end
end
