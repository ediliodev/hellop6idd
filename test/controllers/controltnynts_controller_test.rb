require 'test_helper'

class ControltnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltnynt = controltnynts(:one)
  end

  test "should get index" do
    get controltnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_controltnynt_url
    assert_response :success
  end

  test "should create controltnynt" do
    assert_difference('Controltnynt.count') do
      post controltnynts_url, params: { controltnynt: { limite: @controltnynt.limite, n1: @controltnynt.n1, n2: @controltnynt.n2, n3: @controltnynt.n3, siglas: @controltnynt.siglas, vendida: @controltnynt.vendida } }
    end

    assert_redirected_to controltnynt_url(Controltnynt.last)
  end

  test "should show controltnynt" do
    get controltnynt_url(@controltnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltnynt_url(@controltnynt)
    assert_response :success
  end

  test "should update controltnynt" do
    patch controltnynt_url(@controltnynt), params: { controltnynt: { limite: @controltnynt.limite, n1: @controltnynt.n1, n2: @controltnynt.n2, n3: @controltnynt.n3, siglas: @controltnynt.siglas, vendida: @controltnynt.vendida } }
    assert_redirected_to controltnynt_url(@controltnynt)
  end

  test "should destroy controltnynt" do
    assert_difference('Controltnynt.count', -1) do
      delete controltnynt_url(@controltnynt)
    end

    assert_redirected_to controltnynts_url
  end
end
