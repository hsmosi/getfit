require File.dirname(__FILE__) + '/../test_helper'

class CardiosessionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :users, :cardiosessions
  
  def setup
    @quentin = users(:quentin)
    @session = cardiosessions(:quentinrun)
  end
  
  def test_can_access_james_fixtures
    assert(users(:quentin) != nil)
    assert(cardiosessions(:quentinrun) != nil)
  end
  
  def test_relationships
    assert_equal(@quentin.cardiosessions.count, 1)
    assert_equal(@session.user, @quentin)
  end
  
  def test_fixturevalid
    assert(@session.valid?)
  end
  
  def test_invaliddistance
    @session.distance = "a"
    assert(!@session.valid?)
  end
  
  def test_invalidtimetakenastext
    @session.timetakenastext= "a"
    assert(!@session.valid?)
  end
  
  def test_invalidtimetakenastext_hours
    @session.timetakenastext = "24:00:00"
    assert_nil(@session.timetaken)
  end
  
  def test_invalidtimetakenastext_minutes
    @session.timetakenastext = "61:00"
    assert_nil(@session.timetaken)
  end
  
  def test_invalidtimetakenastext_seconds
    @session.timetakenastext = "61"
    assert_nil(@session.timetaken)
  end
  
  def test_texttotime_sec
    @session.timetakenastext = "10"
    assert_not_nil(@session.timetaken)
    assert_equal(@session.timetaken.hour, 0)
    assert_equal(@session.timetaken.min, 0)
    assert_equal(@session.timetaken.sec, 10)
  end
  
  def test_texttotime_minsec
    @session.timetakenastext = "12:34"
    assert_not_nil(@session.timetaken)
    assert_equal(@session.timetaken.hour, 0)
    assert_equal(@session.timetaken.min, 12)
    assert_equal(@session.timetaken.sec, 34)
  end
  
  def test_texttotime_hourminsec
    @session.timetakenastext = "12:13:14"
    assert_not_nil(@session.timetaken)
    assert_equal(@session.timetaken.hour, 12)
    assert_equal(@session.timetaken.min, 13)
    assert_equal(@session.timetaken.sec, 14)
  end
end
