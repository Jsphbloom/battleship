require './spec/spec_helper'

RSpec.describe Game do
    before(:each) do 
        @game = Game.new
        @board_cpu = Board.new
        @board_user = Board.new
        @cruiser_user = Ship.new("Cruiser", 3)
        @submarine_user = Ship.new("Submarine", 2)
        @cruiser_cpu = Ship.new("Cruiser", 3)
        @submarine_cpu = Ship.new("Submarine", 2)
    end

    it 'can generate random coords' do
        @game.random_coord_generator
    end

end