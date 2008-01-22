require File.dirname(__FILE__) + '/../test_helper'

class TimeHelperTest < ActiveSupport::TestCase
  fixtures :users, :bodies
  
  def test_time_from_text_seconds
    time = Time.time_from_text("30")
    assert_equal(30, time.sec)
    assert_equal(0, time.hour)
    assert_equal(0, time.min)
  end
  
  def test_time_from_text_minutes
    time = Time.time_from_text("10:00")
    assert_equal(0, time.sec)
    assert_equal(10, time.min)
    assert_equal(0, time.hour)
  end
  
  def test_time_from_text_hours
    time = Time.time_from_text("5:00:00")
    assert_equal(0, time.sec)
    assert_equal(0, time.min)
    assert_equal(5, time.hour)
  end
  
  def test_time_from_text_all
    time = Time.time_from_text("12:34:56")
    assert_equal(56, time.sec)
    assert_equal(34, time.min)
    assert_equal(12, time.hour)
  end
  
  def test_time_as_text_all
    time = Time.mktime(1990,1,1,12,34,56,0)
    assert_equal("12:34:56", time.time_as_text)
  end
end