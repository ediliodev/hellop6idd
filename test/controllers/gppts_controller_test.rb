require 'test_helper'

class GpptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gppt = gppts(:one)
  end

  test "should get index" do
    get gppts_url
    assert_response :success
  end

  test "should get new" do
    get new_gppt_url
    assert_response :success
  end

  test "should create gppt" do
    assert_difference('Gppt.count') do
      post gppts_url, params: { gppt: { nombre: @gppt.nombre, p12: @gppt.p12, p13: @gppt.p13, p23: @gppt.p23, q1: @gppt.q1, q2: @gppt.q2, q3: @gppt.q3, sp: @gppt.sp, t123: @gppt.t123, t13: @gppt.t13, t23: @gppt.t23 } }
    end

    assert_redirected_to gppt_url(Gppt.last)
  end

  test "should show gppt" do
    get gppt_url(@gppt)
    assert_response :success
  end

  test "should get edit" do
    get edit_gppt_url(@gppt)
    assert_response :success
  end

  test "should update gppt" do
    patch gppt_url(@gppt), params: { gppt: { nombre: @gppt.nombre, p12: @gppt.p12, p13: @gppt.p13, p23: @gppt.p23, q1: @gppt.q1, q2: @gppt.q2, q3: @gppt.q3, sp: @gppt.sp, t123: @gppt.t123, t13: @gppt.t13, t23: @gppt.t23 } }
    assert_redirected_to gppt_url(@gppt)
  end

  test "should destroy gppt" do
    assert_difference('Gppt.count', -1) do
      delete gppt_url(@gppt)
    end

    assert_redirected_to gppts_url
  end
end
