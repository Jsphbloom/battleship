require './spec/spec_helper'

RSpec.describe Cell do
    before(:each)do
        @cell = Cell.new("B4")
        @cruiser = Ship.new("Cruiser", 3)
    end

    it 'intialize'do 
        expect(@cell).to be_an_instance_of(Cell)
        expect(@cell.coordinate).to eq("B4")
        expect(@cell.ship).to eq(nil)
    end

    it 'checks if cell is empty' do
        expect(@cell.empty?).to eq(true)

    end

    it 'can place a ship' do
        @cell.place_ship(@cruiser)
        expect(@cell.ship).to eq(@cruiser)
        expect(@cell.empty?).to eq(false)
    end

    it 'can check if a cell is fired upon' do
        expect(@cell.fired_upon?).to eq(false)
        @cell.fire_upon
        expect(@cell.fired_upon?).to eq(true)
    end

    it 'can reduce ship health when fired upon' do
        @cell.place_ship(@cruiser)
        @cell.fire_upon
        expect(@cell.fired_upon?).to eq(true)
        expect(@cell.ship.health).to eq(2)
    end
end