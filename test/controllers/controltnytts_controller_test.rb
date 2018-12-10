require 'test_helper'

class ControltnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltnytt = controltnytts(:one)
  end

  test "should get index" do
    get controltnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_controltnytt_url
    assert_response :success
  end

  test "should create controltnytt" do
    assert_difference('Controltnytt.count') do
      post controltnytts_url, params: { controltnytt: { limite: @controltnytt.limite, n1: @controltnytt.n1, n2: @controltnytt.n2, n3: @controltnytt.n3, siglas: @controltnytt.siglas, vendida: @controltnytt.vendida } }
    end

    assert_redirected_to controltnytt_url(Controltnytt.last)
  end

  test "should show controltnytt" do
    get controltnytt_url(@controltnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltnytt_url(@controltnytt)
    assert_response :success
  end

  test "should update controltnytt" do
    patch controltnytt_url(@controltnytt), params: { controltnytt: { limite: @controltnytt.limite, n1: @controltnytt.n1, n2: @controltnytt.n2, n3: @controltnytt.n3, siglas: @controltnytt.siglas, vendida: @controltnytt.vendida } }
    assert_redirected_to controltnytt_url(@controltnytt)
  end

  test "should destroy controltnytt" do
    assert_difference('Controltnytt.count', -1) do
      delete controltnytt_url(@controltnytt)
    end

    assert_redirected_to controltnytts_url
  end
end
