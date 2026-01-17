class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :order, null: false, foreign_key: true
      t.string :reference
      t.string :status
      t.decimal :pretax_total_amount
      t.decimal :total_amount
      t.decimal :vat_amount
      t.decimal :paid_amount

      t.timestamps
    end
  end
end
