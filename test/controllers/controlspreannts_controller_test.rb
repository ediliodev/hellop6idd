require 'test_helper'

class ControlspreanntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlspreannt = controlspreannts(:one)
  end

  test "should get index" do
    get controlspreannts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlspreannt_url
    assert_response :success
  end

  test "should create controlspreannt" do
    assert_difference('Controlspreannt.count') do
      post controlspreannts_url, params: { controlspreannt: { limite: @controlspreannt.limite, n1: @controlspreannt.n1, n2: @controlspreannt.n2, siglas: @controlspreannt.siglas, vendida: @controlspreannt.vendida } }
    end

    assert_redirected_to controlspreannt_url(Controlspreannt.last)
  end

  test "should show controlspreannt" do
    get controlspreannt_url(@controlspreannt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlspreannt_url(@controlspreannt)
    assert_response :success
  end

  test "should update controlspreannt" do
    patch controlspreannt_url(@controlspreannt), params: { controlspreannt: { limite: @controlspreannt.limite, n1: @controlspreannt.n1, n2: @controlspreannt.n2, siglas: @controlspreannt.siglas, vendida: @controlspreannt.vendida } }
    assert_redirected_to controlspreannt_url(@controlspreannt)
  end

  test "should destroy controlspreannt" do
    assert_difference('Controlspreannt.count', -1) do
      delete controlspreannt_url(@controlspreannt)
    end

    assert_redirected_to controlspreannts_url
  end
end
