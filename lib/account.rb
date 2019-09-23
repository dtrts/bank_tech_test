class Account
  ERR_FRACTIONAL = 'Unable to process fractional pence'.freeze

  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << { amount: amount, datetime: Time.now }
  end

  def withdraw(amount)
    @transactions << { amount: -amount, datetime: Time.now }
  end

  def statement
    print_statement = statement_header
    balance = 0

    @transactions.each do |transaction|
      balance += transaction[:amount]
      print_statement << statement_date(transaction)
      print_statement << statement_credit_debit(transaction)
      print_statement << '%.2f' % balance
      print_statement << "\n"
    end

    print_statement
  end

  private

  def statement_header
    "date || credit || debit || balance\n"
  end

  def statement_date(transaction)
    transaction[:datetime].strftime('%d/%m/%Y') + ' ||'
  end

  def statement_credit_debit(transaction)
    if transaction[:amount] > 0
      ' || ' + format('%.2f', transaction[:amount]) + ' || '
    else
      ' ' + format('%.2f', (-1 * transaction[:amount])) + ' || || '
    end
  end
end
