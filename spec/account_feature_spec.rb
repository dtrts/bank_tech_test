require 'account.rb'

Time_Now_21 = Time.new(2012, 1, 10, 0, 0, 0)
Time_Now_22 = Time.new(2012, 1, 13, 0, 0, 0)
Time_Now_23 = Time.new(2012, 1, 14, 0, 0, 0)
describe Account do
  it 'mimics the criteria in the readme' do
    allow(Time).to receive(:now).and_return(Time_Now_21, Time_Now_22, Time_Now_23)

    subject.deposit(1000)
    subject.deposit(2000)
    subject.withdraw(500)

    expected_statement =  "date || credit || debit || balance\n"
    expected_statement << "14/01/2012 || || 500.00 || 2500.00\n"
    expected_statement << "13/01/2012 || 2000.00 || || 3000.00\n"
    expected_statement << "10/01/2012 || 1000.00 || || 1000.00\n"
    expect(subject.statement).to eq(expected_statement)
  end
end
