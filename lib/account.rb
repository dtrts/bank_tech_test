class Account
  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << [amount, Time.now]
  end

  def statement
    print_statement = "date || credit || debit || balance\n"

    @transactions.each do |transaction|
      print_statement << transaction[1].strftime('%d/%m/%Y')
      print_statement << ' || || '
      print_statement << '%.2f' % transaction[0]
      print_statement << ' || '
      print_statement << '%.2f' % transaction[0]
      print_statement << "\n"
    end
    print_statement
  end
end
