require File.dirname(__FILE__) + '/../test_helper'

class CardiotypeTest < ActiveSupport::TestCase
  fixtures :cardiotypes
  
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
    assert_equal(1,@run.cardiosessions.length)
    assert_equal(5,@swim.cardiosessions.length)
    assert_equal(1,@cycle.cardiosessions.length)
  end
  
  def test_find_by_description_succeed
    run = Cardiotype.find_by_description("Run")
    assert_equal(run, @run)
  end
  
  def test_find_by_description_fail
    z = Cardiotype.find_by_description("Runz")
    assert_nil(z)
  end
end

