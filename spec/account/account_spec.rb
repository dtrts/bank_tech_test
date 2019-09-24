require 'account'

describe Account do
  let(:printer) { double(:printer, statement: 'A statement') }
  let(:printer_class) { double(:printer_class, new: printer) }

  let(:transaction) { double(:transaction) }
  let(:transaction_class) { double(:transaction_class, new: transaction) }

  subject { Account.new(transaction_class, printer_class) }

  describe '#deposit' do
    it 'creates a new transaction' do
      expect(transaction_class).to receive(:new).with(100)
      subject.deposit(100)
    end
  end
  describe '#withdraw' do
    it 'creates a new transaction' do
      amount = (rand * 1000).round(2)
      expect(transaction_class).to receive(:new).with(amount)
      subject.withdraw(-1 * amount)
    end
  end

  describe '#statement' do
    it 'calls the printer with an array with single transaction - deposit' do
      expect(printer).to receive(:statement).with([transaction])
      subject.deposit(100)
      subject.statement
    end

    it 'calls the printer with an array with single transaction - withdraw' do
      expect(printer).to receive(:statement).with([transaction])
      subject.withdraw(100)
      subject.statement
    end

    it 'calls the printer with an array of transactions, x2' do
      expect(printer).to receive(:statement).with([transaction, transaction])
      subject.deposit(100)
      subject.withdraw(100)
      subject.statement
    end
  end
end
