require File.dirname(__FILE__) + '/../test_helper'

class CardiosessionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :cardiotypes, :users, :cardiosessions
  
  def setup
    @quentin = users(:quentin)
    @run_session = cardiosessions(:quentinrun)
    @swim_session = cardiosessions(:quentinswim)
    @run = cardiotypes(:run)
    @swim = cardiotypes(:swim)
  end
  
  def test_can_access_james_fixtures
    assert(users(:quentin) != nil)
    assert(cardiosessions(:quentinrun) != nil)
  end
  
  def test_relationship_to_user
    assert_equal(@run_session.user, @quentin)
  end
  
  def test_relationship_to_type
    assert_equal(@run_session.cardiotype, @run)
    assert_equal(@swim_session.cardiotype, @swim)
  end
  
  def test_fixturevalid
    assert(@run_session.valid?)
  end
  
  def test_invaliddistance
    @run_session.distance = "a"
    assert(!@run_session.valid?)
  end
  
  def test_invalidtimetakenastext
    @run_session.timetakenastext= "a"
    assert(!@run_session.valid?)
  end
  
  def test_invalidtimetakenastext_hours
    @run_session.timetakenastext = "24:00:00"
    assert_nil(@run_session.timetaken)
  end
  
  def test_invalidtimetakenastext_minutes
    @run_session.timetakenastext = "61:00"
    assert_nil(@run_session.timetaken)
  end
  
  def test_invalidtimetakenastext_seconds
    @run_session.timetakenastext = "61"
    assert_nil(@run_session.timetaken)
  end
  
  def test_texttotime_sec
    @run_session.timetakenastext = "10"
    assert_not_nil(@run_session.timetaken)
    assert_equal(@run_session.timetaken.hour, 0)
    assert_equal(@run_session.timetaken.min, 0)
    assert_equal(@run_session.timetaken.sec, 10)
  end
  
  def test_texttotime_minsec
    @run_session.timetakenastext = "12:34"
    assert_not_nil(@run_session.timetaken)
    assert_equal(@run_session.timetaken.hour, 0)
    assert_equal(@run_session.timetaken.min, 12)
    assert_equal(@run_session.timetaken.sec, 34)
  end
  
  def test_texttotime_hourminsec
    @run_session.timetakenastext = "12:13:14"
    assert_not_nil(@run_session.timetaken)
    assert_equal(@run_session.timetaken.hour, 12)
    assert_equal(@run_session.timetaken.min, 13)
    assert_equal(@run_session.timetaken.sec, 14)
  end
end
