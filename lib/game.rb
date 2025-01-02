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
            puts "Arg! The computer's placed it's ships, matey!"
        elsif user_input == "q"
            puts "Goodbye!"
            exit
        else
            puts "Invalid input. Try again."
            main_menu
        end
    end

    def cruiser_random_placement
        random_coords_cruiser = []
        until @board_cpu.valid_placement?(@cruiser_cpu, random_coords_cruiser) == true
            random_coords_cruiser.clear
            random_coord1 = @board_cpu.cells.keys.sample
            random_coord2 = @board_cpu.cells.keys.sample
            random_coord3 = @board_cpu.cells.keys.sample
            random_coords_cruiser << random_coord1
            random_coords_cruiser << random_coord2
            random_coords_cruiser << random_coord3
        end
        @board_cpu.place(@cruiser_cpu, random_coords_cruiser)
    end

    def sub_random_placement
        random_coords_sub = []
        until @board_cpu.valid_placement?(@submarine_cpu, random_coords_sub) == true
            random_coords_sub.clear
            random_coord1 = @board_cpu.cells.keys.sample
            random_coord2 = @board_cpu.cells.keys.sample
            random_coords_sub << random_coord1
            random_coords_sub << random_coord2
        end
        @board_cpu.place(@submarine_cpu, random_coords_sub)
        # binding.pry
    end

    def player_cruiser_placement
        cruiser_user_coords = gets.chomp.upcase.delete(",").split
        if @board_user.valid_placement?(@cruiser_user, cruiser_user_coords) == true
            @board_user.place(@cruiser_user, cruiser_user_coords)
        else
            p "invalid placement, try again!"
            player_cruiser_placement
        end
    end

    def player_sub_placement
        sub_user_coords = gets.chomp.upcase.delete(",").split
        if @board_user.valid_placement?(@submarine_user, sub_user_coords) == true
            @board_user.place(@submarine_user, sub_user_coords)
        else
            p "invalid placement, try again!"
            player_sub_placement
        end
    end

    def user_turn
        if
            @board_cpu.cells["A1"].fired_upon? == false &&
            @board_cpu.cells["A2"].fired_upon? == false &&
            @board_cpu.cells["A3"].fired_upon? == false &&
            @board_cpu.cells["A4"].fired_upon? == false &&
            @board_cpu.cells["B1"].fired_upon? == false &&
            @board_cpu.cells["B2"].fired_upon? == false &&
            @board_cpu.cells["B3"].fired_upon? == false &&
            @board_cpu.cells["B4"].fired_upon? == false &&
            @board_cpu.cells["C1"].fired_upon? == false &&
            @board_cpu.cells["C2"].fired_upon? == false &&
            @board_cpu.cells["C3"].fired_upon? == false &&
            @board_cpu.cells["C4"].fired_upon? == false &&
            @board_cpu.cells["D1"].fired_upon? == false &&
            @board_cpu.cells["D2"].fired_upon? == false &&
            @board_cpu.cells["D3"].fired_upon? == false &&
            @board_cpu.cells["D4"].fired_upon? == false
                @board_cpu.render
                @board_user.render(true)
                p "the top one is your enemy's board, the bottom is yours! Protect it with your life!"
                p "Choose a coordinate to fire upon your enemy's board."
        else
            p "Choose a coordinate to fire upon your enemy's board."
        end

        fire = gets.chomp.upcase
        if @board_cpu.cells[fire].fired_upon? == true
            p "already shot, try again!"
            user_turn
        else
            @board_cpu.cells[fire].fire_upon
        end

        if @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship != nil && @board_cpu.cells[fire].ship.sunk? == true
            p "your shot on #{fire} sunk their ship!"
            @board_cpu.render
        elsif @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship != nil
            p "your shot on #{fire} was a hit!"
            @board_cpu.render
        else @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship == nil
            p "your shot on #{fire} was a miss!"
            @board_cpu.render
        end
        game_over?
        cpu_turn
    end
    
    def cpu_turn
        random_cpu_shot = @board_user.cells.keys.sample
        if @board_user.cells[random_cpu_shot].fired_upon? == true
            cpu_turn
        else
            @board_user.cells[random_cpu_shot].fire_upon            
        end

        if @board_user.cells[random_cpu_shot].fired_upon? == true && @board_user.cells[random_cpu_shot].ship != nil && @board_user.cells[random_cpu_shot].ship.sunk? == true
            p "The computer's shot on #{random_cpu_shot} sunk your ship!"
            @board_user.render(true)
        elsif @board_user.cells[random_cpu_shot].fired_upon? == true && @board_user.cells[random_cpu_shot].ship != nil
            p "The computer's shot on #{random_cpu_shot} was a hit!"
            @board_user.render(true)
        else @board_user.cells[random_cpu_shot].fired_upon? == true && @board_user.cells[random_cpu_shot].ship == nil
            p "The computer's shot on #{random_cpu_shot} was a miss!"
            @board_user.render(true)
        end
        game_over?
        user_turn
    end

    def game_over?(finish = false)
        if @cruiser_cpu.sunk? == true && @submarine_cpu.sunk? == true
            p "you win ya scallywag!"
            finish = true
            p "this is the computer's board!"
            @board_cpu.render
            p "this is your board!"
            @board_user.render
            exit
        elsif @cruiser_user.sunk? == true && @submarine_user.sunk? == true
            p "Ya lose! Swab the deck!"
            finish = true
            p "this is the computer's board!"
            @board_cpu.render
            p "this is your board!"
            @board_user.render
            exit
        else
            finish = false
        end
    end
end
