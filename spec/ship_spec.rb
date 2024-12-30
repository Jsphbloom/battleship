require './spec/spec_helper'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
        @cell_1 = Cell.new("B4")
        @cell_2 = Cell.new("C3")
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

    it 'returns a string when rendered' do
        expect(@cell_1.render).to eq(".")
    end

    it 'displays the correct string when render is called' do
        @cell_2.place_ship(@cruiser)
        expect(@cell_2.render).to eq(".")
        @cell_2.fire_upon
        expect(@cell_2.render).to eq("H")
        @cell_1.fire_upon
        expect(@cell_1.render).to eq("M")
    end

    it 'displays S when called true' do
        @cell_2.place_ship(@cruiser)
        expect(@cell_2.render(true)).to eq("S")
        expect(@cell_2.render).to eq(".")
    end

end