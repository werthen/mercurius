class AddCodeToFaculties < ActiveRecord::Migration
  def change
    add_column :faculties, :code, :string
  end
end
