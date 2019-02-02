require 'test_helper'

class ActivacionclientetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activacionclientet = activacionclientets(:one)
  end

  test "should get index" do
    get activacionclientets_url
    assert_response :success
  end

  test "should get new" do
    get new_activacionclientet_url
    assert_response :success
  end

  test "should create activacionclientet" do
    assert_difference('Activacionclientet.count') do
      post activacionclientets_url, params: { activacionclientet: { clienteid: @activacionclientet.clienteid, email: @activacionclientet.email, tipocliente: @activacionclientet.tipocliente } }
    end

    assert_redirected_to activacionclientet_url(Activacionclientet.last)
  end

  test "should show activacionclientet" do
    get activacionclientet_url(@activacionclientet)
    assert_response :success
  end

  test "should get edit" do
    get edit_activacionclientet_url(@activacionclientet)
    assert_response :success
  end

  test "should update activacionclientet" do
    patch activacionclientet_url(@activacionclientet), params: { activacionclientet: { clienteid: @activacionclientet.clienteid, email: @activacionclientet.email, tipocliente: @activacionclientet.tipocliente } }
    assert_redirected_to activacionclientet_url(@activacionclientet)
  end

  test "should destroy activacionclientet" do
    assert_difference('Activacionclientet.count', -1) do
      delete activacionclientet_url(@activacionclientet)
    end

    assert_redirected_to activacionclientets_url
  end
end
