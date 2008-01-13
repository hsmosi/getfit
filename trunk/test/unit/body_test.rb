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
    puts @quentinbodyone.measurementdate.class
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
end
