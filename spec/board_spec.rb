require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do 
        @board = Board.new
    end

    it 'can intitialize' do
        expect(@board).to be_an_instance_of(Board)
    end

    it 'can check cells' do
        expect(@board.cells.size).to eq(16)
        expect(@board.cells).to be_a(Hash)
    end
end