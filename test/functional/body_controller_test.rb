require File.dirname(__FILE__) + '/../test_helper'

class BodyControllerTest < ActionController::TestCase
  fixtures :users, :bodies
  # Replace this with your real tests.
  def setup
    @controller = BodyController.new
    @request = ActionController::TestRequest.new
    @response =  ActionController::TestResponse.new
  end
  
  def test_index
    login_as(:quentin)
    get :index
    assert_response(:success)
    assert_not_nil(assigns["bodies"])
    assert_equal(6, assigns["bodies"].length)
  end
  
  def test_new_load
    login_as(:quentin)
    get :new
    assert_response(:success)
    assert_not_nil(assigns["currentbody"])
    assert_nil(assigns["currentbody"].id)
  end
  
  def test_new_save_success
    original_row_count = Body.find(:all).length
    login_as(:quentin)
    post :new, :currentbody => { :measurementdate => Date.today, :weight => 75 }
    assert_response(:redirect)
    assert_equal(original_row_count + 1, Body.find(:all).length)
  end
  
  def test_new_save_failed
    original_row_count = Body.find(:all).length
    login_as(:quentin)
    post :new, :currentbody => { :measurementdate => Date.today }
    assert_response(:success)
    assert(assigns["currentbody"].errors.length > 0)
    assert_equal(original_row_count , Body.find(:all).length)
  end
  
  def test_edit_load_succeed
    body = bodies(:quentinbodyone)
    
    login_as(:quentin)
    get :edit, :bodyid => body.id
    assert_response(:success)
    assert_not_nil(assigns["currentbody"])
    assert_equal(assigns["currentbody"].id, body.id)
  end
  
  def test_edit_load_failed_missing_body
    login_as(:quentin)
    get :edit, :bodyid => 999
    assert_nil(assigns["currentbody"])
    assert_response(:redirect)
  end
  
  def test_edit_load_failed_unauthorised_to_view_body
    body = bodies(:quentinbodyone)
    
    login_as(:aaron)
    get :edit, :bodyid => body.id
    assert_nil(assigns["currentbody"])
    assert_response(:redirect)
  end
  
  def test_edit_save_succeed
    original_row_count = Body.find(:all).length
    body = bodies(:quentinbodyone)
    login_as(:quentin)
    
    post :edit, :currentbody => { :id => body.id, :weight => 999 }
    assert_response(:redirect)
    assert_not_nil(assigns["currentbody"])
    
    saved_session = Body.find(body.id)
    assert_equal(saved_session.weight, 999)
    assert_equal(original_row_count, Body.find(:all).length) # edit operation so we shouldn't be adding any rows
  end
  
  def test_edit_save_failed
    original_row_count = Body.find(:all).length
    body = bodies(:quentinbodyone)
    login_as(:quentin)
    
    post :edit, :currentbody => { :id => body.id, :weight => "z" }
    assert_response(:success)
    assert_not_nil(assigns["currentbody"])
    
    saved_session = Body.find(body.id)
    assert_equal(saved_session.weight, body.weight)
    assert_equal(original_row_count, Body.find(:all).length)
  end
  
  def test_delete_succeed
    original_row_count = Body.find(:all).length
    body = bodies(:quentinbodyone)
    login_as(:quentin)
    
    get :delete, :bodyid => body.id

    assert_response(:redirect)
    assert_equal(original_row_count - 1, Body.find(:all).length)
  end
  
  def test_delete_failed_missing_body
    original_row_count = Body.find(:all).length
    login_as(:quentin)
    
    get :delete, :bodyid => 999

    assert_response(:redirect)
    assert_equal(original_row_count, Body.find(:all).length)
  end
  
  def test_delete_failed_unauthorised_body
    original_row_count = Body.find(:all).length
    body = bodies(:aaronbodyone)
    login_as(:quentin)
    
    get :delete, :bodyid => body.id

    assert_response(:redirect)
    assert_equal(original_row_count, Body.find(:all).length)
  end
end
