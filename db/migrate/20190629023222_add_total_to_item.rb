class AddTotalToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :total, :decimal, precision: 10, scale: 2, after: 'discount'
  end
end
