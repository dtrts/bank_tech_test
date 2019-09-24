# Account
require_relative './transaction.rb'
class Account
  def initialize(transaction_class = Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount)
    @transactions << @transaction_class.new(amount)
  end

  def withdraw(amount)
    @transactions << @transaction_class.new(-amount)
  end

  def statement
    balance = 0
    print_statement = ''
    @transactions.each do |transaction|
      balance += transaction.amount
      print_statement =  "\n" + print_statement
      print_statement =  format('%.2f', balance) + print_statement
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
    transaction.datetime.strftime('%d/%m/%Y') + ' ||'
  end

  def statement_credit_debit(transaction)
    if transaction.amount.positive?
      ' ' + format('%.2f', transaction.amount) + ' || || '
    else
      ' || ' + format('%.2f', -1 * transaction.amount) + ' || '
    end
  end
end
