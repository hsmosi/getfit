require File.dirname(__FILE__) + '/../test_helper'

class BodyTest < ActiveSupport::TestCase
  fixtures :users, :bodies
  
  def setup
    @quentin = users(:quentin)
    @quentinbodyone = bodies(:quentinbodyone)
    @quentinbodytwo = bodies(:quentinbodytwo)
    @aaron = users(:aaron)
    @aaronbodyone = bodies(:aaronbodyone)
  end
  
  def test_relationship_to_user
    assert_equal(@quentinbodyone.user, @quentin)
    assert_equal(@aaronbodyone.user, @aaron)
  end
  
  def test_fixturevalid
    assert(@quentinbodyone.valid?)
  end
  
  def test_invalidweight
    @quentinbodyone.weight = "z"
    assert(!@quentinbodyone.valid?)
  end
  
  def test_missingweight
    @quentinbodyone.weight = nil
    assert(!@quentinbodyone.valid?)
  end
  
  def test_missingdate
    @quentinbodyone.measurementdate = nil
    assert(!@quentinbodyone.valid?)
  end
  
  def test_for_user
    results = Body.for_user(@quentin)
    assert_not_nil(results)
    assert_equal(results.length, 6)
  end
  
  def test_topfive_gets_five
    results = Body.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(results.length, 5)
  end
  
  def test_topfive_excludes_oldest
    results = Body.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(0, results.select { |r| r.id == 6 }.length)
  end
  
  def test_topfive_order
    results = Body.top_five(@quentin)
    assert_not_nil(results)
    assert_equal(1, results[0].id)
    assert_equal(5, results[4].id)
  end
  
  def test_lastmonth_count
    results = Body.last_month(@quentin)
    assert_not_nil(results)
    assert_equal(4, results.length)
  end
end
