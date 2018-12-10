require 'test_helper'

class ControltgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltgmt = controltgmts(:one)
  end

  test "should get index" do
    get controltgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_controltgmt_url
    assert_response :success
  end

  test "should create controltgmt" do
    assert_difference('Controltgmt.count') do
      post controltgmts_url, params: { controltgmt: { limite: @controltgmt.limite, n1: @controltgmt.n1, n2: @controltgmt.n2, n3: @controltgmt.n3, siglas: @controltgmt.siglas, vendida: @controltgmt.vendida } }
    end

    assert_redirected_to controltgmt_url(Controltgmt.last)
  end

  test "should show controltgmt" do
    get controltgmt_url(@controltgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltgmt_url(@controltgmt)
    assert_response :success
  end

  test "should update controltgmt" do
    patch controltgmt_url(@controltgmt), params: { controltgmt: { limite: @controltgmt.limite, n1: @controltgmt.n1, n2: @controltgmt.n2, n3: @controltgmt.n3, siglas: @controltgmt.siglas, vendida: @controltgmt.vendida } }
    assert_redirected_to controltgmt_url(@controltgmt)
  end

  test "should destroy controltgmt" do
    assert_difference('Controltgmt.count', -1) do
      delete controltgmt_url(@controltgmt)
    end

    assert_redirected_to controltgmts_url
  end
end
