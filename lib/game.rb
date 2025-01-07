require './spec/spec_helper'
require 'rainbow/refinement'
using Rainbow

class Game 
    attr_accessor :board_cpu, :board_user, :cruiser_user, :cruiser_cpu, :submarine_user, :submarine_cpu

    def initialize
        # @board_user = Board.new
        # @board_cpu = Board.new
        @board_cpu = nil
        @board_user = nil
        @cruiser_user = Ship.new("Cruiser", 3)
        @submarine_user = Ship.new("Submarine", 2)
        @cruiser_cpu = Ship.new("Cruiser", 3)
        @submarine_cpu = Ship.new("Submarine", 2)
    end

    def main_menu   
        puts " "
        puts Rainbow("Welcome to BATTLESHIP").bright.turquoise
        puts " "
        puts " .  o .."
        puts " o . o o.o"
        puts "      ...oo                    _~"
        puts "       __[]__               _~ )_)_~"
        puts "    __|_o_o_o|__            )_))_))_)"
        puts "    |||||||||||/            _!__!__!__"
        puts "     |. ..  . /            |________t/"
        puts " ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        puts " "
        puts Rainbow("Enter p to play. Enter q to quit.").turquoise.italic
        user_input = gets.chomp
        puts " "
        if user_input == "p"
            puts Rainbow("Arg! The computer's placed it's ships, matey!").firebrick
            puts " "
        elsif user_input == "q"
            puts Rainbow("Goodbye!").indianred
            exit
        else
            puts Rainbow("Invalid input. Try again.").red.bright
            main_menu
        end
    end

################################

    def get_dimension_height
        puts " "
        puts Rainbow("Choose a number from 0 to 25.").limegreen
        puts " "
        height = gets.chomp.to_i
        if height > 25 || height < 0
            get_dimension_height
        end
        return height
    end

    def get_dimension_width
        puts " "
        puts Rainbow("Choose any positive number.").limegreen
        puts " "
        width = gets.chomp.to_i
        if width.negative?
            get_dimension_width
        end
        return width
    end

    def setup_boards
        height = get_dimension_height
        width = get_dimension_width
        @board_cpu = Board.new(height, width)
        @board_user = Board.new(height, width)
    end

###############################

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
    end

    def player_cruiser_placement
        cruiser_user_coords = gets.chomp.upcase.delete(",").split
        if @board_user.valid_placement?(@cruiser_user, cruiser_user_coords) == true
            @board_user.place(@cruiser_user, cruiser_user_coords)
        else
            puts Rainbow("Invalid placement, try again!").bright.red
            player_cruiser_placement
        end
    end

    def player_sub_placement
        sub_user_coords = gets.chomp.upcase.delete(",").split
        if @board_user.valid_placement?(@submarine_user, sub_user_coords) == true
            @board_user.place(@submarine_user, sub_user_coords)
        else
            puts Rainbow("Invalid placement, try again!").bright.red
            player_sub_placement
        end
    end

    def user_turn
        if @board_cpu.cells.all? {|coordinate, cell| cell.fired_upon? == false}
        #     @board_cpu.cells["A1"].fired_upon? == false &&
        #     @board_cpu.cells["A2"].fired_upon? == false &&
        #     @board_cpu.cells["A3"].fired_upon? == false &&
        #     @board_cpu.cells["A4"].fired_upon? == false &&
        #     @board_cpu.cells["B1"].fired_upon? == false &&
        #     @board_cpu.cells["B2"].fired_upon? == false &&
        #     @board_cpu.cells["B3"].fired_upon? == false &&
        #     @board_cpu.cells["B4"].fired_upon? == false &&
        #     @board_cpu.cells["C1"].fired_upon? == false &&
        #     @board_cpu.cells["C2"].fired_upon? == false &&
        #     @board_cpu.cells["C3"].fired_upon? == false &&
        #     @board_cpu.cells["C4"].fired_upon? == false &&
        #     @board_cpu.cells["D1"].fired_upon? == false &&
        #     @board_cpu.cells["D2"].fired_upon? == false &&
        #     @board_cpu.cells["D3"].fired_upon? == false &&
        #     @board_cpu.cells["D4"].fired_upon? == false
                puts " "
                @board_cpu.render
                puts " "
                @board_user.render(true)
                puts " "
                puts Rainbow("The top one is your enemy's board, the bottom is yours! Protect it with your life!").gold
                puts " "
                puts Rainbow("Choose a coordinate to fire upon your enemy's board.").limegreen
        else
            puts " "
            puts Rainbow("Choose a coordinate to fire upon your enemy's board.").limegreen
        end

        fire = gets.chomp.upcase
        if @board_cpu.cells[fire].fired_upon? == true
            puts " "
            puts Rainbow( "Already shot, try again!").red
            puts " "
            user_turn
        else
            @board_cpu.cells[fire].fire_upon
        end

        if @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship != nil && @board_cpu.cells[fire].ship.sunk? == true
            puts " "
            puts Rainbow("Your shot on #{fire} sunk their ship!").bright.red
            puts " "
            @board_cpu.render
        elsif @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship != nil
            puts " "
            puts Rainbow("Your shot on #{fire} was a hit!").orange
            puts " "
            @board_cpu.render
        else @board_cpu.cells[fire].fired_upon? == true && @board_cpu.cells[fire].ship == nil
            puts " "
            puts Rainbow("Your shot on #{fire} was a miss!").yellow
            puts " "
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
            puts " "
            puts Rainbow("The computer's shot on #{random_cpu_shot} sunk your ship!").bright.red
            puts " "
            @board_user.render(true)
        elsif @board_user.cells[random_cpu_shot].fired_upon? == true && @board_user.cells[random_cpu_shot].ship != nil
            puts " "
            puts Rainbow("The computer's shot on #{random_cpu_shot} was a hit!").orange
            puts " "
            @board_user.render(true)
        else @board_user.cells[random_cpu_shot].fired_upon? == true && @board_user.cells[random_cpu_shot].ship == nil
            puts " "
            puts Rainbow("The computer's shot on #{random_cpu_shot} was a miss!").yellow
            puts " "
            @board_user.render(true)
        end
        game_over?
        user_turn
    end

    def game_over?(finish = false)
        if @cruiser_cpu.sunk? == true && @submarine_cpu.sunk? == true
            puts " "
            puts Rainbow("You win ya scallywag!").bright.limegreen
            finish = true
            puts " "
            puts Rainbow("This is the computer's board!").firebrick
            puts " "
            @board_cpu.render(true)
            puts " "
            puts Rainbow("This is your board!").limegreen
            puts " "
            @board_user.render(true)
            puts " "
            winning_ship
            end_of_game
        elsif @cruiser_user.sunk? == true && @submarine_user.sunk? == true
            puts " "
            puts Rainbow("Ya lose! Swab the deck!").bright.red
            finish = true
            puts " "
            puts Rainbow("This is the computer's board!").firebrick
            puts " "
            @board_cpu.render(true)
            puts " "
            puts Rainbow("This is your board!").limegreen
            puts " "
            @board_user.render(true)
            losing_explosion
            end_of_game
        else
            finish = false
        end
    end

    def end_of_game
        puts Rainbow("To play again, enter p. To quit, enter q").turquoise
        input = gets.chomp.upcase.strip
        if input == "P" 
            load('./spec/runner.rb')
        elsif input == "Q"
            exit
        else
            puts Rainbow("Invalid input, try again").red
            end_of_game
        end
    end

    def winning_ship
        puts "                                          |__"
        puts "                                          | ||"
        puts "             YOU WIN!!!                    ---"
        puts "                                          / | ["
        puts "                                   !      | |||"
        puts "                                 _/|     _/|-++'"
        puts "                             +  +--|    |--|--|_ |-"
        puts "                          { /|__|  |/|__|  |--- |||__/"
        puts "                         +---------------___[}-_===_.'____                 /|"
        puts "                     ____`-' ||___-{]_| _[}-  |     |_[___|==--            ||   _"
        puts "      __..._____--==/___]_|__|_____________________________[___|==--____,------' .7"
        puts "    |                                                                   JB-2412/"
        puts "     |________________________________________________________________________/"
        puts "       "
    end

    def losing_explosion
        puts "          _.-^^---....,,--_"       
        puts "       _--        --       --_"  
        puts "     <                        >)"
        puts "     |        YOU LOSE...      |"
        puts "      \._                   _./ " 
        puts "         ```--. . , ; .--''' "      
        puts "               | |   |"             
        puts "            .-=||  | |=-."   
        puts "            `-=#$%&%$#=-'"   
        puts "               | ;  :|"     
        puts "       _____.,-#%&$@%#&#~,._____"
        puts "       "
    end
end


#remove ships from initialize, replace with empty hashes for user and cpu
#add method for creating ships using gets.chomp
    #how many different kinds of ships (gets.chomp x)
    #(loop x times) name and size of each ship (ship(gets.chomp, gets.chomp))
        #specify quantity
            #shovel into ships hash (both user and cpu)

#update ships place method to loop x times for each ship based on it's length

# random_coord1 = @board_cpu.cells.keys.sample
# random_coord2 = @board_cpu.cells.keys.sample
# random_coords_sub << random_coord1
# random_coords_sub << random_coord2           TURN INTO LOOP!