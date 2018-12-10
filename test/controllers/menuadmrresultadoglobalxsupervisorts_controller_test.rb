require 'test_helper'

class MenuadmrresultadoglobalxsupervisortsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuadmrresultadoglobalxsupervisort = menuadmrresultadoglobalxsupervisorts(:one)
  end

  test "should get index" do
    get menuadmrresultadoglobalxsupervisorts_url
    assert_response :success
  end

  test "should get new" do
    get new_menuadmrresultadoglobalxsupervisort_url
    assert_response :success
  end

  test "should create menuadmrresultadoglobalxsupervisort" do
    assert_difference('Menuadmrresultadoglobalxsupervisort.count') do
      post menuadmrresultadoglobalxsupervisorts_url, params: { menuadmrresultadoglobalxsupervisort: { balance: @menuadmrresultadoglobalxsupervisort.balance, desde: @menuadmrresultadoglobalxsupervisort.desde, ganadores: @menuadmrresultadoglobalxsupervisort.ganadores, hasta: @menuadmrresultadoglobalxsupervisort.hasta, supervisor: @menuadmrresultadoglobalxsupervisort.supervisor, venta: @menuadmrresultadoglobalxsupervisort.venta } }
    end

    assert_redirected_to menuadmrresultadoglobalxsupervisort_url(Menuadmrresultadoglobalxsupervisort.last)
  end

  test "should show menuadmrresultadoglobalxsupervisort" do
    get menuadmrresultadoglobalxsupervisort_url(@menuadmrresultadoglobalxsupervisort)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuadmrresultadoglobalxsupervisort_url(@menuadmrresultadoglobalxsupervisort)
    assert_response :success
  end

  test "should update menuadmrresultadoglobalxsupervisort" do
    patch menuadmrresultadoglobalxsupervisort_url(@menuadmrresultadoglobalxsupervisort), params: { menuadmrresultadoglobalxsupervisort: { balance: @menuadmrresultadoglobalxsupervisort.balance, desde: @menuadmrresultadoglobalxsupervisort.desde, ganadores: @menuadmrresultadoglobalxsupervisort.ganadores, hasta: @menuadmrresultadoglobalxsupervisort.hasta, supervisor: @menuadmrresultadoglobalxsupervisort.supervisor, venta: @menuadmrresultadoglobalxsupervisort.venta } }
    assert_redirected_to menuadmrresultadoglobalxsupervisort_url(@menuadmrresultadoglobalxsupervisort)
  end

  test "should destroy menuadmrresultadoglobalxsupervisort" do
    assert_difference('Menuadmrresultadoglobalxsupervisort.count', -1) do
      delete menuadmrresultadoglobalxsupervisort_url(@menuadmrresultadoglobalxsupervisort)
    end

    assert_redirected_to menuadmrresultadoglobalxsupervisorts_url
  end
end
