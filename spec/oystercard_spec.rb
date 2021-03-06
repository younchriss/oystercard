require 'oystercard'
describe Oystercard do

  let (:entry_station) {'Oxford Street'}

  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:top_up) }
  it { is_expected.to respond_to(:in_journey) }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  describe '.balance' do
    it 'returns the balance of the card' do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up()" do
    it "adds balance to the card" do
      expect(subject.top_up(5)).to eq 5
    end
    it "edge case for max top up allowed" do
      expect(subject.top_up(90)).to eq 90
    end

    it 'throws an error when trying to exceed £90' do
      expect { subject.top_up(91) }.to raise_error("Can't exceed limit of £90")
    end
  end

  describe '.touch_in' do
    it 'changes in_journey to be true' do
      subject.top_up(5)
      subject.touch_in(:entry_station)
      expect(subject.in_journey).to eq true
    end
    it "throws an error if balance has insufficent funds" do
      expect { subject.touch_in(:entry_station)}.to raise_error "Not enough credit, TOP UP!"
    end

    it 'remembers the entry station' do
      subject.top_up(5)
      subject.touch_in(:entry_station)
      expect(subject.entry_station).to eq :entry_station
    end
    
  end
  describe '.touch_out' do
    it 'changes in_journey to be false' do
      subject.top_up(5)
      subject.touch_in(:entry_station)
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
    it 'deducts min fare when you touch out' do
      subject.top_up(5)
      subject.touch_in(:entry_station)
      expect {subject.touch_out}.to change{subject.balance}.by(-1)
    end
  end





end
