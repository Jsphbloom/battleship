require './spec/spec_helper'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end

    it 'can initialize' do
        expect(@cruiser).to be_an_instance_of(Ship)
        expect(@cruiser.name).to eq("Cruiser")
        expect(@cruiser.length).to eq(3)
        expect(@cruiser.health).to eq(@cruiser.length)
    end

    it 'determines if ship is sunk or not' do
        expect(@cruiser.sunk?).to eq(false)
    end

    it 'determines if ship can take hits' do
        @cruiser.hit
        expect(@cruiser.health).to eq(2)
        @cruiser.hit
        expect(@cruiser.health).to eq(1)
        @cruiser.hit
        expect(@cruiser.health).to eq(0)
    end

    it 'determines if ship can become sunk' do
        expect(@cruiser.sunk?).to eq(false)
        @cruiser.hit
        @cruiser.hit
        @cruiser.hit
        expect(@cruiser.sunk?).to eq(true)
    end
end