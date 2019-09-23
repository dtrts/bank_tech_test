require 'account.rb'

describe Account do
  it 'mimics the criteria in the readme' do
    header = "date || credit || debit || balance\n"
    allow(Time).to receive(:now).and_return(Time.new(2012, 1, 10, 0, 0, 0), Time.new(2012, 1, 13, 0, 0, 0), Time.new(2012, 1, 14, 0, 0, 0))
    subject.deposit(1000)
    subject.deposit(2000)
    subject.withdraw(500)
    expect(subject.statement).to eq("date || credit || debit || balance\n" + "14/01/2012 || || 500.00 || 2500.00\n" + "13/01/2012 || 2000.00 || || 3000.00\n" + "10/01/2012 || 1000.00 || || 1000.00\n")
  end
end
