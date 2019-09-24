# Account
require_relative './transaction.rb'
require_relative './printer.rb'

class Account
  def initialize(transaction_class = Transaction,printer_class = Printer)
    @transaction_class = transaction_class
    @printer = printer_class.new
    @transactions = []
  end

  def deposit(amount)
    @transactions << @transaction_class.new(amount)
  end

  def withdraw(amount)
    @transactions << @transaction_class.new(-amount)
  end

  def statement
    @printer.statement(@transactions)
  end
end
