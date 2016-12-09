class CreateItems < ActiveRecord::Migration
  def change
    create_table(:items) do |t|
      t.column(:name, :string)
      t.column(:price, :float)
    end
  end
end
