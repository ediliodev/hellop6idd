require 'test_helper'

class ImpresiontsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @impresiont = impresionts(:one)
  end

  test "should get index" do
    get impresionts_url
    assert_response :success
  end

  test "should get new" do
    get new_impresiont_url
    assert_response :success
  end

  test "should create impresiont" do
    assert_difference('Impresiont.count') do
      post impresionts_url, params: { impresiont: { jugadas: @impresiont.jugadas, ticket_id: @impresiont.ticket_id } }
    end

    assert_redirected_to impresiont_url(Impresiont.last)
  end

  test "should show impresiont" do
    get impresiont_url(@impresiont)
    assert_response :success
  end

  test "should get edit" do
    get edit_impresiont_url(@impresiont)
    assert_response :success
  end

  test "should update impresiont" do
    patch impresiont_url(@impresiont), params: { impresiont: { jugadas: @impresiont.jugadas, ticket_id: @impresiont.ticket_id } }
    assert_redirected_to impresiont_url(@impresiont)
  end

  test "should destroy impresiont" do
    assert_difference('Impresiont.count', -1) do
      delete impresiont_url(@impresiont)
    end

    assert_redirected_to impresionts_url
  end
end
