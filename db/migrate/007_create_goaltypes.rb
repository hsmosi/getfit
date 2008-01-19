class CreateGoaltypes < ActiveRecord::Migration
  def self.up
    create_table :goaltypes do |t|
      t.string :genericdescription, :null => false
      t.string :templatedescription, :null => false
      t.string :focus, :null => false, :limit => false
      t.timestamps
    end
    
    Fixtures.create_fixtures('test/fixtures', File.basename("goaltypes.yml", '.*'))
  end

  def self.down
    drop_table :goaltypes
  end
end
