class AddUrlToLecturers < ActiveRecord::Migration
  def change
    add_column :lecturers, :url, :string
  end
end
