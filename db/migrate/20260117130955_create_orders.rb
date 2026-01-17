class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :account, null: false, index: true, foreign_key: true
      t.references :customer, null: false, index: true, foreign_key: true
      t.references :fulfillment
      t.string :reference
      t.string :customer_firstname
      t.string :customer_lastname
      t.string :customer_address
      t.string :account_firstname
      t.string :account_lastname
      t.string :account_address
      t.string :status
      t.datetime :ordered_at
      t.datetime :cancelled_at
      t.decimal :vat_price
      t.decimal :pretax_total_price
      t.decimal :total_price

      t.timestamps
    end

    create_table :order_lines do |t|
      t.references :order, index: true, foreign_key: true
      t.string :name
      t.integer :quantity
      t.decimal :vat_rate
      t.decimal :vat_price
      t.decimal :pretax_unit_price
      t.decimal :unit_price

      t.timestamps
    end
  end
end
