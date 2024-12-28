require './spec/spec_helper'
class Game 
    attr_accessor :board_cpu, :board_user, :cruiser_user, :cruiser_cpu, :submarine_user, :submarine_cpu

    def initialize
        @board_cpu = Board.new
        @board_user = Board.new
        @cruiser_user = Ship.new("Cruiser", 3)
        @submarine_user = Ship.new("Submarine", 2)
        @cruiser_cpu = Ship.new("Cruiser", 3)
        @submarine_cpu = Ship.new("Submarine", 2)
    end

    def main_menu   
        puts "Welcome to BATTLESHIP
        Enter p to play. Enter q to quit."
        user_input = gets.chomp
        if user_input == "p"
            setup
        elsif user_input == "q"
            puts "Goodbye!"
        else 
            puts "Invalid input."
            user_input
        end
    end
        
    def random_coord_generator
        # random_coords = []
        # @board_cpu.place(@cruiser_cpu, random_coords)
            random_coord_cruiser = @board_cpu.cells.to_a.sample[0]
            random_coord_cruiser_2 = random_coord_cruiser.ord + 1 
            binding.pry
        #     random_coord_cruiser_3 = @board_cpu.cells.to_a.sample[0]
        #     random_coords << random_coord_cruiser
        #     random_coords << random_coord_cruiser_2
        #     random_coords << random_coord_cruiser_3
        #     binding.pry

        # @board_cpu.place(@cruiser_cpu, random_coords)
        
    end

    def setup
    # place cpu ships with random, but valid coordinates for BOTH ships

        # 
        
        
    end
end