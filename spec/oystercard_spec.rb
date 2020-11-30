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
      allow(card).to receive(:top_up).and_return(50)
      card.top_up(50)
      p card.balance 
      expect { card.top_up(41) }.to raise_error "top-up limit exceeded"
    end
  end


end
