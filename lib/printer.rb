class Printer
  HEADER = "date || credit || debit || balance\n".freeze

  def statement(transactions)
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
    line = ''
    line += format_transaction_datetime(transaction)
    line += '||'
    line += format_transaction_deposit(transaction)
    line += '||'
    line += format_transaction_withdrawal(transaction)
    line += '||'
    line += format_balance(balance)
    line += "\n"
  end

  def format_transaction_datetime(transaction)
    transaction.datetime.strftime('%d/%m/%Y') + ' '
  end

  def format_transaction_deposit(transaction)
    if transaction.deposit?
      ' ' + format('%.2f', transaction.amount) + ' '
    else
      ' '
    end
  end

  def format_transaction_withdrawal(transaction)
    if transaction.withdrawal?
      ' ' + format('%.2f', -1 * transaction.amount) + ' '
    else
      ' '
    end
  end

  def format_balance(balance)
    ' ' + format('%.2f', balance)
  end
end
