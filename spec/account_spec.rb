require 'account.rb'
describe Account do
  it 'will print the header from the statement' do
    expect(subject.statement).to eq("date || credit || debit || balance\n")
  end
end
