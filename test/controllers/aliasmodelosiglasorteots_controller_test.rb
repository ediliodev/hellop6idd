require 'test_helper'

class AliasmodelosiglasorteotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aliasmodelosiglasorteot = aliasmodelosiglasorteots(:one)
  end

  test "should get index" do
    get aliasmodelosiglasorteots_url
    assert_response :success
  end

  test "should get new" do
    get new_aliasmodelosiglasorteot_url
    assert_response :success
  end

  test "should create aliasmodelosiglasorteot" do
    assert_difference('Aliasmodelosiglasorteot.count') do
      post aliasmodelosiglasorteots_url, params: { aliasmodelosiglasorteot: { modelocontrolp: @aliasmodelosiglasorteot.modelocontrolp, modelocontrolq: @aliasmodelosiglasorteot.modelocontrolq, modelocontrolsp: @aliasmodelosiglasorteot.modelocontrolsp, modelocontrolt: @aliasmodelosiglasorteot.modelocontrolt, modeloventap: @aliasmodelosiglasorteot.modeloventap, modeloventaq: @aliasmodelosiglasorteot.modeloventaq, modeloventasp: @aliasmodelosiglasorteot.modeloventasp, modeloventat: @aliasmodelosiglasorteot.modeloventat, nombre: @aliasmodelosiglasorteot.nombre, siglasorteo: @aliasmodelosiglasorteot.siglasorteo } }
    end

    assert_redirected_to aliasmodelosiglasorteot_url(Aliasmodelosiglasorteot.last)
  end

  test "should show aliasmodelosiglasorteot" do
    get aliasmodelosiglasorteot_url(@aliasmodelosiglasorteot)
    assert_response :success
  end

  test "should get edit" do
    get edit_aliasmodelosiglasorteot_url(@aliasmodelosiglasorteot)
    assert_response :success
  end

  test "should update aliasmodelosiglasorteot" do
    patch aliasmodelosiglasorteot_url(@aliasmodelosiglasorteot), params: { aliasmodelosiglasorteot: { modelocontrolp: @aliasmodelosiglasorteot.modelocontrolp, modelocontrolq: @aliasmodelosiglasorteot.modelocontrolq, modelocontrolsp: @aliasmodelosiglasorteot.modelocontrolsp, modelocontrolt: @aliasmodelosiglasorteot.modelocontrolt, modeloventap: @aliasmodelosiglasorteot.modeloventap, modeloventaq: @aliasmodelosiglasorteot.modeloventaq, modeloventasp: @aliasmodelosiglasorteot.modeloventasp, modeloventat: @aliasmodelosiglasorteot.modeloventat, nombre: @aliasmodelosiglasorteot.nombre, siglasorteo: @aliasmodelosiglasorteot.siglasorteo } }
    assert_redirected_to aliasmodelosiglasorteot_url(@aliasmodelosiglasorteot)
  end

  test "should destroy aliasmodelosiglasorteot" do
    assert_difference('Aliasmodelosiglasorteot.count', -1) do
      delete aliasmodelosiglasorteot_url(@aliasmodelosiglasorteot)
    end

    assert_redirected_to aliasmodelosiglasorteots_url
  end
end
