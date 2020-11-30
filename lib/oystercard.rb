class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    fail 'top-up limit exceeded' if money + balance > MAX_BALANCE
    @balance += money
  end

end
