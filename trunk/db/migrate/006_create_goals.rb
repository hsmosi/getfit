class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.string :description, :null => true
      t.date :target_date, :null => false
      t.integer :cardiotype_id, :null => true
      t.time :target_time, :null => true
      t.integer :target_weight, :null => true
      t.integer :user_id, :null => false
      t.boolean :active, :null => false, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
