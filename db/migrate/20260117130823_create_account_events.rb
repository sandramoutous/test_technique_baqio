class CreateAccountEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :account_events do |t|
      t.references :account, null: false, foreign_key: true
      t.references :resource, polymorphic: true, index: true
      t.string :topic

      t.timestamps
    end
  end
end
