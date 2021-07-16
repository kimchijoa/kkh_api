class CreateFlowFs < ActiveRecord::Migration[6.0]
  def change
    create_table :flow_fs do |t|
      t.integer :previousStock
      t.integer :newStock
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
