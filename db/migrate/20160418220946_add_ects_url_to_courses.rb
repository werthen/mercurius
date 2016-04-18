class AddEctsUrlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :ects_url, :string
  end
end
