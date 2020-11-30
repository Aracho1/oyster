require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  it 'has a default balance' do
    expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do
    it 'enables top-up' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'changes balance by top up amount' do
      expect { card.top_up(10) }.to change { card.balance }.by(10)
    end

    # it 'raises an error when top_up exceeds limit' do
    #   card = Oystercard.new
    #   expect { card.top_up(90) }.to raise_error "top-up limit exceeded"
    # end
    it 'raises an error when top_up exceeds limit' do
      # allow(card).to receive(:top_up).and_return(50)
      card.top_up(50)
      expect { card.top_up(41) }.to raise_error "£#{Oystercard::MAX_BALANCE} max. value exceeded"
    end
  end

  # describe '#deduct' do
  #   it 'deducts a fare from the oyster card' do
  #     expect(card).to respond_to(:deduct)
  #     expect{ card.deduct }.to change { card.balance }
  #   end
  # end

  describe '#touch_in' do
    it 'updates the in_journey variable' do
      card.top_up(10)
      card.touch_in("Holborn")
      expect(card.in_journey).to be true
    end

    it 'refuses entry if balance is below minimum balance' do
      card.top_up(0.5)
      expect {card.touch_in("Holborn")}.to raise_error "Below £#{Oystercard::MINIMUM_BALANCE} minimum balance."
    end

    it 'remembers the entry station' do
      card.top_up(10)
      card.touch_in("Holborn")
      expect(card.entry_station).to eq "Holborn"
    end

  end

  describe '#touch_out' do
    it 'updates the in_journey' do
      card.touch_out
      expect(card.in_journey).to be false
    end

    it 'reduces the balance by the amount of fare' do
      card.top_up(10)
      expect {card.touch_out}.to change {card.balance}.from(10).to(8)
    end
  end

end
