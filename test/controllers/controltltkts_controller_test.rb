require 'test_helper'

class ControltltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltltkt = controltltkts(:one)
  end

  test "should get index" do
    get controltltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_controltltkt_url
    assert_response :success
  end

  test "should create controltltkt" do
    assert_difference('Controltltkt.count') do
      post controltltkts_url, params: { controltltkt: { limite: @controltltkt.limite, n1: @controltltkt.n1, n2: @controltltkt.n2, n3: @controltltkt.n3, siglas: @controltltkt.siglas, vendida: @controltltkt.vendida } }
    end

    assert_redirected_to controltltkt_url(Controltltkt.last)
  end

  test "should show controltltkt" do
    get controltltkt_url(@controltltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltltkt_url(@controltltkt)
    assert_response :success
  end

  test "should update controltltkt" do
    patch controltltkt_url(@controltltkt), params: { controltltkt: { limite: @controltltkt.limite, n1: @controltltkt.n1, n2: @controltltkt.n2, n3: @controltltkt.n3, siglas: @controltltkt.siglas, vendida: @controltltkt.vendida } }
    assert_redirected_to controltltkt_url(@controltltkt)
  end

  test "should destroy controltltkt" do
    assert_difference('Controltltkt.count', -1) do
      delete controltltkt_url(@controltltkt)
    end

    assert_redirected_to controltltkts_url
  end
end
