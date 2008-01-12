class Cardiotype < ActiveRecord::Base
  has_many :cardiosessions
  
  validates_presence_of :string
  validates_uniqueness_of :string
end
