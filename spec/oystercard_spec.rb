require 'oystercard'
describe Oystercard do
  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:top_up) }
  it { is_expected.to respond_to(:deduct) }
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
  describe "#deduct()" do
    it "deduce amount from balance for a trip" do
      subject.top_up(15)
      expect(subject.deduct(20)).to eq (-5)
    end
  end
  describe '.touch_in' do
    it 'changes in_journey to be true' do
      expect(subject.touch_in).to eq true
    end
  end
  describe '.touch_out' do
    it 'changes in_journey to be false' do
      subject.touch_in
      expect(subject.touch_out).to eq false
    end
  end

end
