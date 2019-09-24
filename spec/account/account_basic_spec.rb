require 'account.rb'
describe Account do
  test_time = Time.new(1990, 2, 15, 0, 0, 0)

  let(:transaction) { double(:transaction) }
  let(:transaction_class) { double(:transaction_class, new: transaction) }
  subject { Account.new(transaction_class) }

  describe 'basic statements' do
    before(:each) do
      allow(Time).to receive(:now).and_return(test_time)
    end

    it 'will print the header from the statement' do
      expected_statement = "date || credit || debit || balance\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'a deposit appears on the statement' do
      allow(transaction).to receive(:amount).and_return(100)
      allow(transaction).to receive(:datetime).and_return(test_time)
      subject.deposit(100)

      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "15/02/1990 || 100.00 || || 100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'a withdrawal appears on the statement' do
      allow(transaction).to receive(:amount).and_return(-100)
      allow(transaction).to receive(:datetime).and_return(test_time)
      subject.withdraw(100)

      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "15/02/1990 || || 100.00 || -100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end
  end
end
