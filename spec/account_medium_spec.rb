require 'account.rb'
describe Account do
  header = "date || credit || debit || balance\n"

  describe 'multi line statements' do
    it 'two deposits on the statement' do
      allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0), Time.new(1990, 3, 16, 0, 0, 0))

      subject.deposit(100)
      subject.deposit(50.60)
      expect(subject.statement).to eq(header + "16/03/1990 || 50.60 || || 150.60\n" + "15/02/1990 || 100.00 || || 100.00\n")
    end
    it 'two withdrawals on the statement' do
      allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0), Time.new(1990, 3, 16, 0, 0, 0))

      subject.withdraw(100)
      subject.withdraw(50.60)
      expect(subject.statement).to eq(header + "16/03/1990 || || 50.60 || -150.60\n" + "15/02/1990 || || 100.00 || -100.00\n")
    end

    it 'two withdrawals on the statement' do
      allow(Time).to receive(:now).and_return(Time.new(1990, 2, 15, 0, 0, 0), Time.new(1990, 3, 16, 0, 0, 0))

      subject.deposit(100)
      subject.withdraw(50.60)
      expect(subject.statement).to eq(header + "16/03/1990 || || 50.60 || 49.40\n" + "15/02/1990 || 100.00 || || 100.00\n")
    end
  end
end
