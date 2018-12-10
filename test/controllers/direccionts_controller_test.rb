require 'test_helper'

class DirecciontsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @direcciont = direccionts(:one)
  end

  test "should get index" do
    get direccionts_url
    assert_response :success
  end

  test "should get new" do
    get new_direcciont_url
    assert_response :success
  end

  test "should create direcciont" do
    assert_difference('Direcciont.count') do
      post direccionts_url, params: { direcciont: { cuidadt_id: @direcciont.cuidadt_id, direccion: @direcciont.direccion, sector: @direcciont.sector } }
    end

    assert_redirected_to direcciont_url(Direcciont.last)
  end

  test "should show direcciont" do
    get direcciont_url(@direcciont)
    assert_response :success
  end

  test "should get edit" do
    get edit_direcciont_url(@direcciont)
    assert_response :success
  end

  test "should update direcciont" do
    patch direcciont_url(@direcciont), params: { direcciont: { cuidadt_id: @direcciont.cuidadt_id, direccion: @direcciont.direccion, sector: @direcciont.sector } }
    assert_redirected_to direcciont_url(@direcciont)
  end

  test "should destroy direcciont" do
    assert_difference('Direcciont.count', -1) do
      delete direcciont_url(@direcciont)
    end

    assert_redirected_to direccionts_url
  end
end
