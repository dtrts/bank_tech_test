require 'printer.rb'

describe Printer do
  test_time = Time.new(1990, 2, 15, 0, 0, 0)
  let(:transaction) { double(:transaction) }

  it 'returns header from empty transaction array' do
    expected_value = "date || credit || debit || balance\n"
    transactions = []
    expect(subject.statement(transactions)).to eq(expected_value)
  end

  it 'prints a single deposit' do
    allow(transaction).to receive(:amount).and_return(100)
    allow(transaction).to receive(:datetime).and_return(test_time)
    allow(transaction).to receive(:deposit?).and_return(true)
    allow(transaction).to receive(:withdrawal?).and_return(false)

    transactions = [transaction]

    expected_statement = "date || credit || debit || balance\n"
    expected_statement += "15/02/1990 || 100.00 || || 100.00\n"

    expect(subject.statement(transactions)).to eq(expected_statement)
  end

  it 'prints a single withdrawal' do
    allow(transaction).to receive(:amount).and_return(-100)
    allow(transaction).to receive(:datetime).and_return(test_time)
    allow(transaction).to receive(:deposit?).and_return(false)
    allow(transaction).to receive(:withdrawal?).and_return(true)

    transactions = [transaction]

    expected_statement = "date || credit || debit || balance\n"
    expected_statement += "15/02/1990 || || 100.00 || -100.00\n"

    expect(subject.statement(transactions)).to eq(expected_statement)
  end
end
