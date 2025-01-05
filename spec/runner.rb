require './spec/spec_helper'
require 'rainbow/refinement'
using Rainbow

    game = Game.new

    game.main_menu

    ###
    
    game.setup_boards

    game.board_user.render
    puts " "
    puts Rainbow("Here's yer board, exactly to specifications!").limegreen

    ###

    game.cruiser_random_placement
    
    game.sub_random_placement
    
    game.board_user.render(true)
    puts "                                    "
    puts Rainbow("Your turn sailor! Place yer cruiser! Enter 3 coordinates to place your ship.").limegreen
    
    
    game.player_cruiser_placement  
    puts "                                    "
    game.board_user.render(true)

    puts "                                    "
    puts Rainbow("Great job captain! next up, place your submarine! Only 2 coordinates for this one!").limegreen
    puts "                                    "
    
    game.player_sub_placement
    puts "                                    "
    game.board_user.render(true)

    puts "                                    "
    puts Rainbow("Nice typing! Now the game can begin!").gold
    
    game.user_turn
    game.end_of_game
    

