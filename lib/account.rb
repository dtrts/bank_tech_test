class Account
  ERR_FRACTIONAL = 'Unable to process fractional pence'.freeze
  ERR_NAN = 'A valid number or float must be provided'.freeze

  def initialize
    @transactions = []
  end

  def deposit(amount)
    guard_type(amount)
    guard_fractional(amount)
    @transactions << { amount: amount, datetime: Time.now }
  end

  def withdraw(amount)
    guard_type(amount)
    guard_fractional(amount)
    @transactions << { amount: -amount, datetime: Time.now }
  end

  def statement
    balance = 0
    print_statement = ''
    @transactions.each do |transaction|
      balance += transaction[:amount]
      print_statement =  "\n" + print_statement
      print_statement =  '%.2f' % balance + print_statement
      print_statement =  statement_credit_debit(transaction) + print_statement
      print_statement =  statement_date(transaction) + print_statement
    end

    print_statement = statement_header + print_statement
  end

  private

  def statement_header
    "date || credit || debit || balance\n"
  end

  def statement_date(transaction)
    transaction[:datetime].strftime('%d/%m/%Y') + ' ||'
  end

  def statement_credit_debit(transaction)
    if transaction[:amount].positive?
      ' ' + format('%.2f', transaction[:amount]) + ' || || '
    else
      ' || ' + format('%.2f', -1 * transaction[:amount]) + ' || '
    end
  end

  def guard_fractional(amount)
    raise ERR_FRACTIONAL if fractional?(amount)
  end

  def fractional?(amount)
    ((amount * 100) % 1).nonzero?
  end

  def guard_type(amount)
    raise ERR_NAN unless amount.is_a?(Numeric)
  end
end
