# frozen_string_literal: true

require_relative './transaction.rb'
require_relative './printer.rb'

# Account
class Account
  ERR_NEGATIVE_BALANCE = 'Insufficient funds'
  # rubocop:disable Metrics/LineLength
  ERR_NON_POSITIVE_TRANSACTION = 'Cannot process a transaction with non positive value'
  # rubocop:enable Metrics/LineLength

  def initialize(transaction_class = Transaction, printer_class = Printer)
    @transaction_class = transaction_class
    @printer = printer_class.new
    @transactions = []
  end

  def deposit(amount)
    raise ERR_NON_POSITIVE_TRANSACTION if amount <= 0

    @transactions.push(@transaction_class.new(amount)).dup
  end

  def withdraw(amount)
    raise ERR_NEGATIVE_BALANCE if insufficient_funds?(amount)
    raise ERR_NON_POSITIVE_TRANSACTION if amount <= 0

    @transactions.push(@transaction_class.new(-amount)).dup
  end

  def statement
    @printer.statement(@transactions)
  end

  private

  def insufficient_funds?(amount)
    amount > current_balance
  end

  def current_balance
    @transactions.reduce(0.0) do |balance, transaction|
      balance + transaction.amount.to_f
    end
  end
end
