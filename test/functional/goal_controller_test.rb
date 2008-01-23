require File.dirname(__FILE__) + '/../test_helper'

class GoalControllerTest < ActionController::TestCase
  fixtures :users, :goals, :goaltypes
  
  def setup
    @controller = GoalController.new
    @request = ActionController::TestRequest.new
    @response =  ActionController::TestResponse.new
  end
  
  def test_index
    login_as(:quentin)
    get :index
    assert_response(:success)
    assert_not_nil(assigns["activegoals"])
    assert_not_nil(assigns["completedgoals"])
    assert_equal(5, assigns["activegoals"].length)
    assert_equal(2, assigns["completedgoals"].length)
  end
  
  def test_new_success
    original_row_count = Goal.find(:all).length
    login_as(:quentin)
    get :new
    assert_response(:success)
    post :new, :goal => { :goaltype_id => 1, :target_date => Date.today, :target_weight => 100 }
    assert_response(:redirect)
    assert_equal(original_row_count + 1, Goal.find(:all).length)
  end
  
  def test_new_fail
    original_row_count = Goal.find(:all).length
    login_as(:quentin)
    get :new
    assert_response(:success)
    post :new, :goal => { :goaltype_id => 1, :target_date => Date.today }
    assert_response(:success)
    assert_not_nil(assigns["goal"])
    assert_not_nil(assigns["goal"].errors)
    assert_equal(1, assigns["goal"].errors.length)
    assert_equal(original_row_count, Goal.find(:all).length)
  end
  
  def test_delete_success
    original_row_count = Goal.find(:all).length
    login_as(:quentin)
    get :delete, :goalid => 1
    assert_response(:redirect)
    assert_equal(original_row_count - 1, Goal.find(:all).length)
  end
  
  def test_delete_fail
    original_row_count = Goal.find(:all).length
    login_as(:aaron)
    get :delete, :goalid => 1
    assert_response(:redirect)
    assert_equal(original_row_count, Goal.find(:all).length)
  end
end
