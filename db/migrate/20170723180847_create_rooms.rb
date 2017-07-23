class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :guests
      t.integer :max_guests
      t.integer :status
      t.string :type

      t.timestamps
    end
  end
end
