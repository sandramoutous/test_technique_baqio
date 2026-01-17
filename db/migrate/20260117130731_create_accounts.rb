class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :address

      t.timestamps
    end
  end
end
