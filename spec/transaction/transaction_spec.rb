require 'transaction.rb'

describe 'Transaction' do
  it 'exposes the amount' do
    amount = (rand * 1000).round(2)
    transaction = Transaction.new(amount)
    expect(transaction.amount).to eq(amount)
  end
  it 'exposes the date created' do
    test_time = Time.new(1990, 2, 15, 0, 0, 0)
    allow(Time).to receive(:now).and_return(test_time)
    transaction = Transaction.new(100)
    expect(transaction.datetime).to eq(test_time)
  end

  describe 'value checking for deposit and withdrawal' do
    it 'throws error on fractional pence - deposit' do
      expect { Transaction.new(0.001) }.to raise_error(Transaction::ERR_FRACTIONAL)
    end
    it 'throws error on fractional pence - withdraw' do
      expect { Transaction.new(-0.001) }.to raise_error(Transaction::ERR_FRACTIONAL)
    end
    it 'throws error on string type' do
      expect { Transaction.new('a string') }.to raise_error(Transaction::ERR_NAN)
    end

    it 'throws error on string type' do
      expect { Transaction.new('a string') }.to raise_error(Transaction::ERR_NAN)
    end
  end
end
