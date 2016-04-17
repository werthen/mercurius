class CreateProgrammes < ActiveRecord::Migration
  def change
    create_table :programmes do |t|
      t.string :name
      t.references :faculty, index: true

      t.timestamps null: false
    end
    add_foreign_key :programmes, :faculties
  end
end
