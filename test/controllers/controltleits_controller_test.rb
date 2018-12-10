require 'test_helper'

class ControltleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltleit = controltleits(:one)
  end

  test "should get index" do
    get controltleits_url
    assert_response :success
  end

  test "should get new" do
    get new_controltleit_url
    assert_response :success
  end

  test "should create controltleit" do
    assert_difference('Controltleit.count') do
      post controltleits_url, params: { controltleit: { limite: @controltleit.limite, n1: @controltleit.n1, n2: @controltleit.n2, n3: @controltleit.n3, siglas: @controltleit.siglas, vendida: @controltleit.vendida } }
    end

    assert_redirected_to controltleit_url(Controltleit.last)
  end

  test "should show controltleit" do
    get controltleit_url(@controltleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltleit_url(@controltleit)
    assert_response :success
  end

  test "should update controltleit" do
    patch controltleit_url(@controltleit), params: { controltleit: { limite: @controltleit.limite, n1: @controltleit.n1, n2: @controltleit.n2, n3: @controltleit.n3, siglas: @controltleit.siglas, vendida: @controltleit.vendida } }
    assert_redirected_to controltleit_url(@controltleit)
  end

  test "should destroy controltleit" do
    assert_difference('Controltleit.count', -1) do
      delete controltleit_url(@controltleit)
    end

    assert_redirected_to controltleits_url
  end
end
