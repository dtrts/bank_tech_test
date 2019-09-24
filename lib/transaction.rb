class Transaction
  ERR_FRACTIONAL = 'Unable to process fractional pence'.freeze
  ERR_NAN = 'A valid number or float must be provided'.freeze

  def initialize(amount)
    guard_type(amount)
    guard_fractional(amount)
    @amount = amount
    @datetime = Time.now
  end

  def amount
    @amount.dup
  end

  def datetime
    @datetime.dup
  end

  private

  def guard_fractional(amount)
    raise ERR_FRACTIONAL if fractional?(amount)
  end

  def fractional?(amount)
    ((amount * 100) % 1).nonzero?
  end

  def guard_type(amount)
    raise ERR_NAN unless amount.is_a?(Numeric)
  end
end
