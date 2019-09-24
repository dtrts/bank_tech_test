require 'transaction.rb'

describe 'Transaction' do
  describe '#amount' do
    it 'exposes the value' do
      100.times do
        amount = (rand * 1000).round(2)
        transaction = Transaction.new(amount)
        expect(transaction.amount).to eq(amount)
      end
    end
    it 'deals with 79.29' do
      # 79.29 * 100 returns a long float which failed the fractional pence check
      transaction = Transaction.new(79.29)
      expect(transaction.amount).to eq(79.29)
    end
  end

  describe '#datetime' do
    it 'exposes the value' do
      test_time = Time.new(1990, 2, 15, 0, 0, 0)
      allow(Time).to receive(:now).and_return(test_time)
      transaction = Transaction.new(100)
      expect(transaction.datetime).to eq(test_time)
    end
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
