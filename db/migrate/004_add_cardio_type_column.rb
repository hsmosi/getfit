class AddCardioTypeColumn < ActiveRecord::Migration
  def self.up
    run = Cardiotype.find(:first, :conditions => ["description = ?", "Run"])
    add_column :cardiosessions, :cardiotype_id, :integer, :null => false, :default => run.id
  end

  def self.down
    remove_column :cardiosessions, :cardiotype_id
  end
end
