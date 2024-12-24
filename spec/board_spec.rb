require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do 
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end

    it 'can initialize' do
        expect(@board).to be_an_instance_of(Board)
    end

    it 'can check cells' do
        expect(@board.cells.size).to eq(16)
        expect(@board.cells).to be_a(Hash)
    end

    it '#valid_coordinate?' do
        expect(@board.valid_coordinate?("A1")).to eq(true)
        expect(@board.valid_coordinate?("A5")).to eq(false)
    end

    it '#valid_coordinates?' do
        expect(@board.valid_coordinates?(["A1", "A2", "A3"])).to eq(true)
    end

    it '#coordinates_empty?' do
        expect(@board.coordinates_empty?(["A1", "A2"])).to eq(true)
        
    end

    it '#valid_placement' do
        expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to eq(true)
        expect(@board.valid_placement?(@submarine, ["B1", "C1"])).to eq(true)
        expect(@board.valid_placement?(@submarine, ["A1", "A2", "A4"])).to eq(false)
        expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D3"])).to eq(false)
        
    end

    it '#consecutive_letters' do
        expect(@board.consecutive_letters?(["A1", "B1"])).to eq(true)
        expect(@board.consecutive_letters?(["C1", "D1"])).to eq(true)
        expect(@board.consecutive_letters?(["A1", "B1", "C1"])).to eq(true)
        expect(@board.consecutive_letters?(["A1", "C3"])).to eq(false)
        expect(@board.consecutive_letters?(["A1", "A2", "A3"])).to eq(false)
    end

    it '#consecutive_numbers' do
        expect(@board.consecutive_numbers?(["A1", "A2"])).to eq(true)
        expect(@board.consecutive_numbers?(["A1", "A2", "A3"])).to eq(true)
        expect(@board.consecutive_numbers?(["A1", "B1"])).to eq(false)
        expect(@board.consecutive_numbers?(["A1", "B1", "C2"])).to eq(false)
        expect(@board.consecutive_numbers?(["A1", "A2", "C2"])).to eq(false)
        
    end
        
        
    it 'same_letters?' do
        expect(@board.same_letters?(["A1", "A2"])).to eq(true)
        expect(@board.same_letters?(["A1", "A2", "A3"])).to eq(true)
        expect(@board.same_letters?(["A1", "B1"])).to eq(false)
        expect(@board.same_letters?(["A1", "B1", "C2"])).to eq(false)
        expect(@board.same_letters?(["A1", "A2", "C2"])).to eq(false)
    end

    it 'same_numbers?' do
        expect(@board.same_numbers?(["A1", "B1"])).to eq(true)
        expect(@board.same_numbers?(["A2", "A2", "C2"])).to eq(true)
        expect(@board.same_numbers?(["A1", "A2"])).to eq(false)
        expect(@board.same_numbers?(["A1", "A2", "A3"])).to eq(false)
        expect(@board.same_numbers?(["A1", "B1", "C2"])).to eq(false)
    end
end