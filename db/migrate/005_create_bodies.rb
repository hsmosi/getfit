class CreateBodies < ActiveRecord::Migration
  def self.up
    create_table :bodies do |t|
      t.integer :weight, :null => false
      t.date :measurementdate, :null => false
      t.integer :user_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bodies
  end
end
