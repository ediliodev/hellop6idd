require 'test_helper'

class RecordspreanntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordspreannt = recordspreannts(:one)
  end

  test "should get index" do
    get recordspreannts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordspreannt_url
    assert_response :success
  end

  test "should create recordspreannt" do
    assert_difference('Recordspreannt.count') do
      post recordspreannts_url, params: { recordspreannt: { monto: @recordspreannt.monto, n1: @recordspreannt.n1, n2: @recordspreannt.n2, siglas: @recordspreannt.siglas, ticket_id: @recordspreannt.ticket_id } }
    end

    assert_redirected_to recordspreannt_url(Recordspreannt.last)
  end

  test "should show recordspreannt" do
    get recordspreannt_url(@recordspreannt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordspreannt_url(@recordspreannt)
    assert_response :success
  end

  test "should update recordspreannt" do
    patch recordspreannt_url(@recordspreannt), params: { recordspreannt: { monto: @recordspreannt.monto, n1: @recordspreannt.n1, n2: @recordspreannt.n2, siglas: @recordspreannt.siglas, ticket_id: @recordspreannt.ticket_id } }
    assert_redirected_to recordspreannt_url(@recordspreannt)
  end

  test "should destroy recordspreannt" do
    assert_difference('Recordspreannt.count', -1) do
      delete recordspreannt_url(@recordspreannt)
    end

    assert_redirected_to recordspreannts_url
  end
end
