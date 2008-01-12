require File.dirname(__FILE__) + '/../test_helper'

class CardiotypeTest < ActiveSupport::TestCase
  fixtures :cardiotypes, :cardiotypes
  
  def setup
    @run = cardiotypes(:run)
    @swim = cardiotypes(:swim)
    @cycle = cardiotypes(:cycle)
  end
  
  # Replace this with your real tests.
  def test_basedata
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Run"]))
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Swim"]))
    assert_not_nil(Cardiotype.find(:first, :conditions => ["description = ?", "Cycle"]))
  end
  
  def test_relationship_to_cardiosession
    assert_equal(@run.cardiosessions.length, 1)
    assert_equal(@swim.cardiosessions.length, 1)
    assert_equal(@cycle.cardiosessions.length, 0)
  end
end

