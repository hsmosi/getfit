require File.dirname(__FILE__) + '/../test_helper'

class DashboardControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @controller = CardioController.new
    @request = ActionController::TestRequest.new
    @response =  ActionController::TestResponse.new
  end

  def test_index
    login_as(:quentin)
    get :index
    assert_response(:success)
    assert_not_nil(assigns["cardioSessions"])
    assert_not_nil(assigns["bodyStats"])
    assert_not_nil(assigns["graphtype"])
    assert_not_nil(assigns["graphdataurl"])
    assert_not_nil(assigns["graphCaption"])
    assert_equal(5, assigns["cardioSessions"].length)
    assert_equal(5, assigns["bodyStats"].length)
    assert_equal("Run", assigns["graphtype"])
  end
  
  def test_cardioGraphData_Run
    login_as(:quentin)
    get :cardioGraphData, :graphtype => "Run"
    assert_response(:success)
    assert_not_nil(assigns["cardioSessions"])
    assert_not_nil(assigns["minValue"])
    assert_not_nil(assigns["maxValue"])
    
    assert_equal(1, assigns["cardioSessions"].length)
    assert_equal(290, assigns["minValue"])
    assert_equal(310, assigns["maxValue"])
  end
  
  def test_bodyGraphData
    login_as(:quentin)
    get :bodyGraphData, :graphtype => "Run"
    assert_response(:success)
    assert_not_nil(assigns["bodyMetrics"])
    assert_not_nil(assigns["minValue"])
    assert_not_nil(assigns["maxValue"])
    
    assert_equal(4, assigns["bodyMetrics"].length)
    assert_equal(75, assigns["minValue"])
    assert_equal(92, assigns["maxValue"])
  end
end
