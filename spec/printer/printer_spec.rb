require 'printer.rb'

describe Printer do
  it 'returns header from empty transaction array' do
    header = "date || credit || debit || balance\n"
    expect(Printer.statement([])).to eq(header)
  end
end
