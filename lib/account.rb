# frozen_string_literal: true

require_relative './transaction.rb'
require_relative './printer.rb'

# Account
class Account
  def initialize(transaction_class = Transaction, printer_class = Printer)
    @transaction_class = transaction_class
    @printer = printer_class.new
    @transactions = []
  end

  def deposit(amount)
    @transactions.push(@transaction_class.new(amount)).dup
  end

  def withdraw(amount)
    @transactions.push(@transaction_class.new(-amount)).dup
  end

  def statement
    @printer.statement(@transactions)
  end
end
