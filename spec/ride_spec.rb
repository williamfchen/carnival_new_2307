require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do
  describe "iteration 2" do
    let(:ride1) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
    let(:visitor1) {Visitor.new('Bruce', 54, '$10')}
    let(:visitor2) {Visitor.new('Tucker', 36, '$5')}

    it 'exists and has readable attributes' do
      expect(ride1.name).to eq("Carousel")
      expect(ride1.min_height).to eq(24)
      expect(ride1.admission_fee).to eq(1)
      expect(ride1.excitement).to eq(:gentle)
      expect(ride1.rider_log).to eq({})
    end
    
    it 'boards riders' do
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      expect(ride1.rider_log).to be_a Hash
    end
      
    it "calculates revenue" do
      expect(ride1.total_revenue).to eq(0)
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      expect(visitor1.spending_money).to eq(8)
      expect(visitor2.spending_money).to eq(4)
      expect(ride1.total_revenue).to eq(3)
    end
    

  end

end
