class AddCodeToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :code, :string
  end
end
