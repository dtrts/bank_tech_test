class Printer
  HEADER = "date || credit || debit || balance\n".freeze
  def self.statement(_transactions)
    HEADER
  end
end
