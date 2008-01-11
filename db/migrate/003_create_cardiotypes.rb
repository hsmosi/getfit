class CreateCardiotypes < ActiveRecord::Migration
  def self.up
    create_table :cardiotypes do |t|
      t.string :description, :null => false
      t.timestamps
    end
    
    Cardiotype.create :description => "Run"
    Cardiotype.create :description => "Swim"
    Cardiotype.create :description => "Cycle"
  end

  def self.down
    drop_table :cardiotypes
  end
end
