require File.dirname(__FILE__) + '/../test_helper'

class CardiosessionTest < ActiveSupport::TestCase
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
  
  def test_fixture_valid
    assert(@run_session.valid?)
  end
  
  def test_invalid_distance
    @run_session.distance = "a"
    assert(!@run_session.valid?)
  end
  
  def test_invalid_time_taken_as_text
    @run_session.timetakenastext= "a"
    assert(!@run_session.valid?)
  end
  
  def test_invalid_time_taken_as_text_hours
    @run_session.timetakenastext = "24:00:00"
    assert_nil(@run_session.timetaken)
  end
  
  def test_invalid_time_taken_as_text_minutes
    @run_session.timetakenastext = "61:00"
    assert_nil(@run_session.timetaken)
  end
  
  def test_invalid_time_taken_as_text_seconds
    @run_session.timetakenastext = "61"
    assert_nil(@run_session.timetaken)
  end
  
  def test_text_to_time_sec
    @run_session.timetakenastext = "10"
    assert_not_nil(@run_session.timetaken)
    assert_equal(@run_session.timetaken.hour, 0)
    assert_equal(@run_session.timetaken.min, 0)
    assert_equal(@run_session.timetaken.sec, 10)
  end
  
  def test_text_to_time_minsec
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
  
  def test_topfive_gets_five
    results = Cardiosession.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(5, results.length)
  end
  
  def test_topfive_excludes_oldest
    results = Cardiosession.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(0, results.select { |r| r.id == 6 }.length)
  end
  
  def test_topfive_order
    results = Cardiosession.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(1, results[0].id)
    assert_equal(5, results[4].id)
  end
  
  def test_lastmonth_type_all_count
    results = Cardiosession.last_month(@quentin)
    assert_not_nil(results)
    assert_equal(4, results.length)
  end
  
  def test_lastmonth_type_is_swim_count
    results = Cardiosession.last_month(@quentin, @swim)
    assert_not_nil(results)
    assert_equal(3, results.length)
  end
  
  def test_last_session_for_cardio_type_swim
    s = Cardiosession.last_session_for_type(@quentin, Date.today, @swim)
    assert_not_nil(s)
    assert_equal(2, s.id)
  end
  
  def test_last_session
    s = Cardiosession.last_session(@quentin, Date.today)
    assert_not_nil(s)
    assert_equal(1, s.id)
  end
end
