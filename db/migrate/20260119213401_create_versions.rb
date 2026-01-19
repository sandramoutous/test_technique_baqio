class CreateVersions < ActiveRecord::Migration[7.2]
  def change
    create_table :versions do |t|
      t.references :item, polymorphic: true
      t.string :action
      t.string :column
      t.string :value
      t.string :value_changed

      t.timestamps
    end
  end
end
