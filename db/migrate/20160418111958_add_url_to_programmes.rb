class AddUrlToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :url, :string
  end
end
