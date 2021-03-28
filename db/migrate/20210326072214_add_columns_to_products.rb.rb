class AddColumnsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :category_id, :string
    add_column :products, :—force, :string
  end
end