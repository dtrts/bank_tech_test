require 'account.rb'

Time_Now_11 = Time.new(1990, 2, 15, 0, 0, 0)
Time_Now_12 = Time.new(1990, 3, 16, 0, 0, 0)

describe Account do
  before(:each) do
    allow(Time).to receive(:now).and_return(Time_Now_11, Time_Now_12)
  end
  describe 'multi line statements' do
    it 'two deposits on the statement' do
      subject.deposit(100)
      subject.deposit(50.60)

      expected_statement =  "date || credit || debit || balance\n"
      expected_statement << "16/03/1990 || 50.60 || || 150.60\n"
      expected_statement << "15/02/1990 || 100.00 || || 100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'two withdrawals on the statement' do
      subject.withdraw(100)
      subject.withdraw(50.60)

      expected_statement =  "date || credit || debit || balance\n"
      expected_statement << "16/03/1990 || || 50.60 || -150.60\n"
      expected_statement << "15/02/1990 || || 100.00 || -100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'two withdrawals on the statement' do
      subject.deposit(100)
      subject.withdraw(50.60)

      expected_statement =  "date || credit || debit || balance\n"
      expected_statement << "16/03/1990 || || 50.60 || 49.40\n"
      expected_statement << "15/02/1990 || 100.00 || || 100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end
  end

  it 'prevents alteration of the transaction log' do
    subject.deposit(100)
    transaction_log = subject.withdraw(50.60)
    transaction_log[0].amount = 0

    expected_statement =  "date || credit || debit || balance\n"
    expected_statement << "16/03/1990 || || 50.60 || 49.40\n"
    expected_statement << "15/02/1990 || 100.00 || || 100.00\n"
    expect(subject.statement).to eq(expected_statement)
  end
end
