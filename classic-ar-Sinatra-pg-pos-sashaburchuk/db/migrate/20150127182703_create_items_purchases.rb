class CreateItemsPurchases < ActiveRecord::Migration
  def change
    create_table(:items_purchases) do |t|
      t.column(:purchase_id, :int)
      t.column(:item_id, :int)
    end
  end
end
