require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do 
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @cell_1 = @board.cells["A1"]  
        @cell_2 = @board.cells["A2"]
        @cell_3 = @board.cells["A3"]    
        @cell_4 = @board.cells["A4"] 
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

    it 'place' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@cell_1.empty?).to eq(false)
        expect(@cell_2.empty?).to eq(false)
        expect(@cell_3.empty?).to eq(false)
        expect(@cell_4.empty?).to eq(true)
        expect(@cell_2.ship).to eq(@cell_3.ship)
    end

    it 'checks overlapping ships' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
        expect(@board.valid_placement?(@submarine, ["C1", "D1"])).to eq(true)
        expect(@board.valid_placement?(@cruiser, ["D2", "D3", "D4"])).to eq(true)
        @board.place(@cruiser, ["D2", "D3", "D4"])
        expect(@board.valid_placement?(@submarine, ["D1", "D2"])).to eq(false)
        expect(@cell_1.empty?).to eq(false)
    end
    
    it 'renders the board' do
        @board.render
    end

    it 'the board renders a miss' do
        @board.cells["A1"].fire_upon
        @board.render
        expect(@board.cells["A1"].render).to eq("M")
    end

    it 'the board renders a hit' do
        @board.place(@submarine, ["C1", "D1"])
        @board.cells["C1"].fire_upon
        @board.render
        expect(@board.cells["C1"].render).to eq("H")
    end

    it 'the board renders a sunk ship' do
        @board.place(@submarine, ["C1", "D1"])
        @board.cells["C1"].fire_upon
        @board.cells["D1"].fire_upon
        @board.render
        expect(@board.cells["C1"].render).to eq("X")
        expect(@board.cells["D1"].render).to eq("X")
        # binding.pry
    end

    it 'cannot take a duplicate hit' do
        @board.place(@submarine, ["C1", "D1"])
        @board.cells["C1"].fire_upon
        @board.cells["C1"].fire_upon
        @board.render
    end

    it 'can show hidden ships' do
        @board.place(@submarine, ["C1", "D1"])
        @board.cells["C1"].render(debug = true)
        @board.render(true)
    end


end