require 'account.rb'
describe Account do
  header = "date || credit || debit || balance\n"
  it 'will print the header from the statement' do
    expect(subject.statement).to eq(header)
  end

  it 'a deposit appears on the statement' do
    allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0))
    subject.deposit(100)
    expect(subject.statement).to eq(header + "15/02/1990 || || 100.00 || 100.00\n")
  end

  it 'a withdrawal appears on the statement' do
    allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0))
    subject.withdraw(100)
    expect(subject.statement).to eq(header + "15/02/1990 || 100.00 || || -100.00\n")
  end

  describe 'value checking for deposit and withdrawal' do
    xit 'throws error on fractional pence - deposit' do
      expect { subject.deposit(0.001) }.to throw_error(Account::ERR_FRACTIONAL)
    end
    xit 'throws error on fractional pence - withdraw' do
      expect { subject.withdraw(0.001) }.to throw_error(Account::ERR_FRACTIONAL)
    end
  end
end
