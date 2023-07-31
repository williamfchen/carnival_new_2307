require './lib/visitor'

RSpec.describe Visitor do
  describe 'iteration 1' do
    let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
    let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
    let(:visitor3) { Visitor.new('Penny', 64, '$15') }
  
    it 'exists and has readable attributes' do
      expect(visitor1).to be_a(Visitor)
      expect(visitor1.name).to eq("Bruce")
      expect(visitor1.height).to eq(54)
      expect(visitor1.spending_money).to eq(10)
      expect(visitor1.preferences).to eq([])
    end

    it 'adds preferences to visitor' do
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      expect(visitor1.preferences).to eq([:gentle, :thrilling])
    end

    it 'check height for tall enough' do
      expect(visitor1.tall_enough?(54)).to be true
      expect(visitor2.tall_enough?(54)).to be false
      expect(visitor3.tall_enough?(54)).to be true
      expect(visitor1.tall_enough?(64)).to be false
    end
  end
end