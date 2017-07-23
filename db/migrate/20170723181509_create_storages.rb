class CreateStorages < ActiveRecord::Migration[5.1]
  def change
    create_table :storages do |t|
      t.integer :room_id
      t.integer :max_storage
      t.integer :storage

      t.timestamps
    end
  end
end
