require 'transaction.rb'

describe 'Transaction' do
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
