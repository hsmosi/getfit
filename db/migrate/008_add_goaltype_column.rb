class AddGoaltypeColumn < ActiveRecord::Migration
  def self.up
    add_column :goals, :goaltype_id, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :goals, :goaltype_id
  end
end
