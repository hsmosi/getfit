class CreateCardiosessions < ActiveRecord::Migration
  def self.up
    create_table :cardiosessions do |t|
      t.integer :distance, :null => false
      t.date :workoutdate, :null => false
      t.time :timetaken, :null => false
      t.string :comments
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :cardiosessions
  end
end
