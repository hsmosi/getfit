require File.dirname(__FILE__) + '/../test_helper'

class GoalTest < ActiveSupport::TestCase
  fixtures :users, :goaltypes, :goals
  
  def setup
    @quentin = users(:quentin)
    @aaron = users(:aaron)
  end
  
  def test_all_active_count
    qgoals = Goal.all_active(@quentin)
    assert_equal(5, qgoals.length)
    
    agoals = Goal.all_active(@aaron)
    assert_equal(4, agoals.length)
  end
  
  def test_success_deadline_not_yet_passed
    goal = goals(:quentin_target_time_future)
    assert(!goal.succeeded)
  end
  
  def test_success_time_taken_succeed
    goal = goals(:quentin_target_time)
    assert(goal.succeeded)
  end
  
  def test_success_time_taken_fail
    goal = goals(:quentin_target_time_fail)
    assert(!goal.succeeded)
  end
  
  def test_success_distance_succeed
    goal = goals(:quentin_target_distance)
    assert(goal.succeeded)
  end
  
  def test_success_distance_fail
    goal = goals(:quentin_target_distance_fail_today)
    assert(!goal.succeeded)
  end
  
  def test_success_distance_fail_norun
    goal = goals(:quentin_target_distance_fail_norun)
    assert(!goal.succeeded)
  end
  
  def test_success_gain_weight
    goal = goals(:aaron_gain_weight_succeed)
    assert(goal.succeeded)
  end
  
  def test_success_gain_weight_failed
    goal = goals(:aaron_gain_weight_failed)
    assert(!goal.succeeded)
  end
  
  def test_success_lose_weight
    goal = goals(:aaron_lose_weight_succeed)
    assert(goal.succeeded)
  end
  
  def test_success_gain_weight_failed
    goal = goals(:aaron_lose_weight_failed)
    assert(!goal.succeeded)
  end
end
