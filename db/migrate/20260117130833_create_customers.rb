class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.references :account, null: false, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.string :email
      t.string :phone
      t.string :address
      t.string :state

      t.timestamps
    end
  end
end
