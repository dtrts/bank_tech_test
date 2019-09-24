# Transaction
class Transaction
  ERR_FRACTIONAL = 'Unable to process fractional pence'.freeze
  ERR_NAN = 'A valid number or float must be provided'.freeze

  attr_reader :amount, :datetime

  def initialize(amount)
    guard_amount(amount)
    @amount = amount
    @datetime = Time.now
  end

  def deposit?
    @amount.positive?
  end

  def withdrawal?
    !deposit?
  end

  private

  def guard_amount(amount)
    guard_amount_type(amount)
    guard_amount_fractional(amount)
  end

  def guard_amount_type(amount)
    raise ERR_NAN unless amount.is_a?(Numeric)
  end

  def guard_amount_fractional(amount)
    raise ERR_FRACTIONAL if fractional?(amount)
  end

  def fractional?(amount)
    after_decimal_characters = amount.to_s.split('.')[1]
    if after_decimal_characters
      return true if after_decimal_characters.length > 2
    end
    false
  end
end
