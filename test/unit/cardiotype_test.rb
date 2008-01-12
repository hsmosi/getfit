require File.dirname(__FILE__) + '/../test_helper'

class CardiotypeTest < ActiveSupport::TestCase
  fixtures :cardiotypes
  
  # Replace this with your real tests.
  def test_basedata
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Run"]))
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Swim"]))
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Cycle"]))
  end
end

