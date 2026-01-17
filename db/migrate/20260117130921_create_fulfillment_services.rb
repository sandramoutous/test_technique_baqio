class CreateFulfillmentServices < ActiveRecord::Migration[7.2]
  def change
    create_table :fulfillment_services do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :state
      t.string :sales_contact

      t.timestamps
    end
  end
end
