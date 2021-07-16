class CreateFlows < ActiveRecord::Migration[6.0]
  def change
    create_table :flows do |t|
      t.integer :previousStock
      t.integer :newStock

      t.timestamps
    end
  end
end
