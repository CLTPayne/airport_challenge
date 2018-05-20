require 'airport'

describe Airport do
  it 'responds to #land' do
    expect(subject). to respond_to :land
  end

  it 'responds to #take_off' do
    expect(subject). to respond_to :take_off
  end

  describe '#land' do
    let(:plane) { double :plane }
    it 'instructs a plane to land at an airport' do
      airport = Airport.new
      allow(plane).to receive(:stormy?) { false }
      expect(airport.land(plane)).to eq "The following plane: #{plane} has landed"
    end
  end

  context 'when the airport is full' do
    let(:plane) { double :plane }
    let(:plane2) { double :plane2 }
    it 'returns an error and no more planes can land' do
      allow(plane).to receive(:stormy?) { false }
      allow(plane2).to receive(:stormy?) { false }
      airport = Airport.new
      airport.capacity.times { airport.land(plane) }
      expect { airport.land(plane2) }.to raise_error "Airport is full"
    end
  end

  context 'when the weather is too bad to land' do
    let(:plane) { double :plane }
    it 'returns an error, and no planes land' do
      airport = Airport.new
      # plane = Plane.new - shouldn't call a plane when the class under test is airport
      allow(plane).to receive(:stormy?) { true }
      expect { airport.land(plane) }.to raise_error "Unsafe. Due to the storm #{plane} can not land"
    end
  end

  describe '#take_off' do
    let(:plane) { double :plane }
    it 'instructs a plane to take off from an airport' do
      airport = Airport.new
      allow(plane).to receive(:stormy?) { false }
      expect(airport.take_off(plane)).to eq "The following plane: #{plane} has taken off"
    end

    context 'when the weather is too bad to take off' do
      let(:plane) { double :plane }
      it 'returns an error, and no planes leave' do
        airport = Airport.new
        # plane = Plane.new - shouldn't call a plane when the class under test is airport
        allow(plane).to receive(:stormy?) { true }
        expect { airport.take_off(plane) }.to raise_error "Unsafe. Due to the storm #{plane} can not take off"
      end
    end
  end

end
