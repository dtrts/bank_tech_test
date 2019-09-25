# frozen_string_literal: true

# Printer
class Printer
  HEADER = "date || credit || debit || balance\n"
  COLUMN_CHAR = '||'
  PADDING = ' '

  def statement(transactions)
    print(HEADER + printed_transactions(transactions))
    HEADER + printed_transactions(transactions)
  end

  private

  def printed_transactions(transactions)
    balance_after_transaction = 0

    transaction_lines = transactions.map do |transaction|
      balance_after_transaction += transaction.amount
      print_transaction(transaction, balance_after_transaction)
    end

    transaction_lines.reverse.join('')
  end

  def print_transaction(transaction, balance)
    line = format_transaction_datetime(transaction)
    line += COLUMN_CHAR
    line += format_transaction_deposit(transaction)
    line += COLUMN_CHAR
    line += format_transaction_withdrawal(transaction)
    line += COLUMN_CHAR
    line += format_balance(balance)
    line + "\n"
  end

  def format_transaction_datetime(transaction)
    transaction.datetime.strftime('%d/%m/%Y') + PADDING
  end

  def format_transaction_deposit(transaction)
    if transaction.deposit?
      PADDING + format('%.2f', transaction.amount) + PADDING
    else
      PADDING
    end
  end

  def format_transaction_withdrawal(transaction)
    if transaction.withdrawal?
      PADDING + format('%.2f', -1 * transaction.amount) + PADDING
    else
      PADDING
    end
  end

  def format_balance(balance)
    PADDING + format('%.2f', balance)
  end
end
