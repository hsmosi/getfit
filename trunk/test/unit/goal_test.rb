require File.dirname(__FILE__) + '/../test_helper'

class GoalTest < ActiveSupport::TestCase
  fixtures :users, :goaltypes, :goals
  
  def setup
    @quentin = users(:quentin)
    @aaron = users(:aaron)
  end
  
  def test_all_active_count
    qgoals = Goal.all_active(@quentin)
    assert_equal(3, qgoals.length)
    
    agoals = Goal.all_active(@aaron)
    assert_equal(1, agoals.length)
  end
  
  def test_completed_count
    
  end
  
  def test_success_deadline_not_yet_passed
    goal = goals(:quentin_target_time)
    assert(!goal.succeeded)
  end
end
