require File.dirname(__FILE__) + '/../test_helper'

class CardioControllerTest < ActionController::TestCase
  fixtures :users, :cardiosessions
  # Replace this with your real tests.
  def setup
    @controller = CardioController.new
    @request = ActionController::TestRequest.new
    @response =  ActionController::TestResponse.new
  end
  
  def test_index
    login_as(:quentin)
    get :index
    assert_response(:success)
    assert_not_nil(assigns["sessions"])
    assert_equal(6, assigns["sessions"].length)
  end
  
  def test_new_load
    login_as(:quentin)
    get :new
    assert_response(:success)
    assert_not_nil(assigns["currentsession"])
    assert_nil(assigns["currentsession"].id)
  end
  
  def test_new_save_succeed
    original_row_count = Cardiosession.find(:all).length
    login_as(:quentin)
    post :new, :currentsession => { :workoutdate => Time.now, :distance => 2, :timetakenastext => "10:10" }
    assert_response(:redirect)
    assert_equal(original_row_count + 1, Cardiosession.find(:all).length)
  end
  
  def test_new_save_failed
    original_row_count = Cardiosession.find(:all).length
    login_as(:quentin)
    post :new, :currentsession => { :workoutdate => Time.now, :distance => "bad distance", :timetakenastext => "10:10" }
    assert_response(:success)
    assert_equal(original_row_count, Cardiosession.find(:all).length)
  end
  
  def test_edit_load_succeed
    run_session = cardiosessions(:quentinrun)
    
    login_as(:quentin)
    get :edit, :sessionid => run_session.id
    assert_response(:success)
    assert_not_nil(assigns["currentsession"])
    assert_equal(run_session.id, assigns["currentsession"].id)
  end
  
  def test_edit_load_failed_missing_session
    login_as(:quentin)
    get :edit, :sessionid => 999
    assert_nil(assigns["currentsession"])
    assert_response(:redirect)
  end
  
  def test_edit_load_failed_unauthorised_to_view_session
    run_session = cardiosessions(:quentinrun)
    
    login_as(:aaron)
    get :edit, :sessionid => run_session.id
    assert_nil(assigns["currentsession"])
    assert_response(:redirect)
  end
  
  def test_edit_save_succeed
    original_row_count = Cardiosession.find(:all).length
    run_session = cardiosessions(:quentinrun)
    login_as(:quentin)
    
    post :edit, :currentsession => { :id => run_session.id, :distance => 999 }
    assert_response(:redirect)
    assert_not_nil(assigns["currentsession"])
    
    saved_session = Cardiosession.find(:first, :conditions => "id = #{run_session.id}")
    assert_equal(saved_session.distance, 999)
    assert_equal(original_row_count, Cardiosession.find(:all).length) # edit operation so we shouldn't be adding any rows
  end
  
  def test_edit_save_failed
    original_row_count = Cardiosession.find(:all).length
    run_session = cardiosessions(:quentinrun)
    login_as(:quentin)
    
    post :edit, :currentsession => { :id => run_session.id, :distance => "z" }
    assert_response(:success)
    assert_not_nil(assigns["currentsession"])
    
    saved_session = Cardiosession.find(:first, :conditions => "id = #{run_session.id}")
    assert_equal(saved_session.distance, run_session.distance)
    assert_equal(original_row_count, Cardiosession.find(:all).length)
  end
  
  def test_delete_succeed
    original_row_count = Cardiosession.find(:all).length
    run_session = cardiosessions(:quentinrun)
    login_as(:quentin)
    
    get :delete, :sessionid => run_session.id

    assert_response(:redirect)
    assert_equal(original_row_count - 1, Cardiosession.find(:all).length)
  end
  
  def test_delete_failed_missing_body
    original_row_count = Cardiosession.find(:all).length
    login_as(:quentin)
    
    get :delete, :sessionid => 999

    assert_response(:redirect)
    assert_equal(original_row_count, Cardiosession.find(:all).length)
  end
  
  def test_delete_failed_missing_body
    original_row_count = Cardiosession.find(:all).length
    cycle_session = cardiosessions(:aaroncycle)
    login_as(:quentin)
    
    get :delete, :sessionid => cycle_session.id

    assert_response(:redirect)
    assert_equal(original_row_count, Cardiosession.find(:all).length)
  end
end
