class Account < ApplicationRecord
  belongs_to :user
  
  def display_name_with_balance
    "#{user.name} (#{user.user_type}) - $#{sprintf('%.2f', balance)}"
  end
end
