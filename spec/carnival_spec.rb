require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  let(:carnival) { Carnival.new(14) }
  let(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }

  describe 'iteration 3' do
    it 'exists and has readable attributes' do
      expect(carnival).to be_a Carnival
      expect(carnival.duration).to eq(14)
      expect(carnival.rides).to eq([])
    end
    
    it 'adds rides' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      expect(carnival.rides).to eq([ride1, ride2, ride3])
    end
    
    it 'knows the most popular ride' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      expect(visitor2.add_preference(:thrilling)).to eq([:gentle, :thrilling])
      expect(visitor3.add_preference(:thrilling)).to eq([:thrilling])
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      expect(carnival.most_popular_ride).to eq(ride1)
      ride3.board_rider(visitor3)
      expect(carnival.most_popular_ride).to eq(ride1)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      expect(carnival.most_popular_ride).to eq(ride3)
    end

    it 'knows the most profitable ride' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      expect(visitor2.add_preference(:thrilling)).to eq([:gentle, :thrilling])
      expect(visitor3.add_preference(:thrilling)).to eq([:thrilling])
      ride1.board_rider(visitor1)
      expect(carnival.most_profitable_ride).to eq(ride1)
      ride3.board_rider(visitor3)
      expect(carnival.most_profitable_ride).to eq(ride3)
      ride2.board_rider(visitor1)
      expect(carnival.most_profitable_ride).to eq(ride2)
    end
    
    it 'calculates total revenue' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      expect(carnival.total_revenue).to eq(3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      expect(carnival.total_revenue).to eq(7)      
    end
  end
end
