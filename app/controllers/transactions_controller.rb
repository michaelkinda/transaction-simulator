class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:from_account, :to_account).order(created_at: :desc)
    @accounts = Account.includes(:user)
  end

  def create
    # Validate parameters as before
    amount = params[:amount].to_d
    from_id = params[:from_account_id]
    to_id   = params[:to_account_id]

    # Load accounts outside the transaction so they are in scope for redirect
    from = Account.lock.find(from_id)
    to   = Account.lock.find(to_id)

    # Validate different accounts
    if from.id == to.id
      redirect_to transactions_path, alert: "Cannot transfer to the same account" and return
    end

    # Validate funds inside the transaction
    Transaction.transaction do
      raise "Insufficient funds" if from.balance < amount

      from.update!(balance: from.balance - amount)
      to.update!(balance: to.balance + amount)
      Transaction.create!(from_account: from, to_account: to, amount: amount)
    end

    redirect_to transactions_path, notice: "Transaction successful! $#{sprintf('%.2f', amount)} transferred from #{from.user.name} to #{to.user.name}"

  rescue ActiveRecord::RecordNotFound
    redirect_to transactions_path, alert: "One or both accounts not found"
  rescue => e
    redirect_to transactions_path, alert: e.message
  end
end
