require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should create transaction" do
    from_account = accounts(:one)
    to_account = accounts(:two)

    assert_difference "Transaction.count", 1 do
      post transactions_url, params: {
        amount: 5.00,
        from_account_id: from_account.id,
        to_account_id: to_account.id
      }
    end

    assert_redirected_to transactions_path
  end
end
