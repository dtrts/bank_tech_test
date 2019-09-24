# Bank Tech Test

This is a tech test for a simple OO app to manage a bank account.
The main app has no dependencies.
Gems will have to be installed to run the tests.

Tech Stack:
- Ruby/IRB for the implementation.
- Rspec for the Tests.
- Git for version control
- Rubocop for linting locally

## Getting Started
`git clone https://github.com/dtrts/bank_tech_test`

## Usage

`irb -r ./lib/account.rb`
```ruby
account = Account.new
account.deposit(10)
account.withdraw(5)
account.statement
```

## Running Tests
```
bundle install
rspec
```

---

## Specification

### Requirements

- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

Given a client makes a deposit of 1000 on 10-01-2012
And a deposit of 2000 on 13-01-2012
And a withdrawal of 500 on 14-01-2012
When she prints her bank statement
Then she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

## Design / Approach

My approach was to initially build upon some feature tests which encompassed the requirements.
Upon passing all of the feature tests I think looked to extract classes and reduce the responsibility of the single class I had made.



Account class.
Holds balance
Can print a statement.
Deposits and withdrawals can be made.
Deposits and withdrawals.


## Improvements

### Class extraction.
Bring out transaction class.
The transaction class will hold: amount, datetime
The transaction shouldn't be alterable.
Will return a dup

Will manage guarding for fractional amounts and types.
```
tr = Transaction.new(amount)
tr.credit?
tr.debit?
tr.amount
tr.datetime
amount = tr.amount
amount += 10
amount != tr.amount # => true
```

### Class Extraction
Removing a printer class to prepare statements
