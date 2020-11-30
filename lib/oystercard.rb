class Oystercard
  attr_reader :balance, :in_journey, :entry_station


  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 2

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    fail "£#{MAX_BALANCE} max. value exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(station)
    fail "Below £#{Oystercard::MINIMUM_BALANCE} minimum balance." if balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct
    @in_journey = false
  end

  private

  def deduct
    @balance -= FARE
  end

end
