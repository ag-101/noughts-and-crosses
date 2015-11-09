class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :position, limit:  2

      t.timestamps null: false
    end
  end
end
