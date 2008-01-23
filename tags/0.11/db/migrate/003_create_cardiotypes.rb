require 'active_record/fixtures'

class CreateCardiotypes < ActiveRecord::Migration
  def self.up
    create_table :cardiotypes do |t|
      t.string :description, :null => false
      t.timestamps
    end
    
    Fixtures.create_fixtures('test/fixtures', File.basename("cardiotypes.yml", '.*'))
  end

  def self.down
    drop_table :cardiotypes
  end
end
