class CreateFulfillments < ActiveRecord::Migration[7.2]
  def change
    create_table :fulfillments do |t|
      t.references :fulfillment_service, null: false, foreign_key: true
      t.string :status
      t.string :tracking_number
      t.datetime :shipping_date

      t.timestamps
    end
  end
end
