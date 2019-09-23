require 'account.rb'
describe Account do
  describe 'basic statements' do
    before(:each) do
      allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0))
    end

    it 'will print the header from the statement' do
      expected_statement = "date || credit || debit || balance\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'a deposit appears on the statement' do
      subject.deposit(100)

      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "15/02/1990 || 100.00 || || 100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end

    it 'a withdrawal appears on the statement' do
      subject.withdraw(100)

      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "15/02/1990 || || 100.00 || -100.00\n"
      expect(subject.statement).to eq(expected_statement)
    end
  end

  describe 'value checking for deposit and withdrawal' do
    it 'throws error on fractional pence - deposit' do
      expect { subject.deposit(0.001) }.to raise_error(Account::ERR_FRACTIONAL)
    end
    it 'throws error on fractional pence - withdraw' do
      expect { subject.withdraw(0.001) }.to raise_error(Account::ERR_FRACTIONAL)
    end
    it 'throws error on invalid number types - deposit' do
      expect { subject.deposit('a string') }.to raise_error(Account::ERR_NAN)
    end
    it 'throws error on invalid number types - withdraw' do
      expect { subject.withdraw(' a string') }.to raise_error(Account::ERR_NAN)
    end
  end
end
