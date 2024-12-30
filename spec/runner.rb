require './spec/spec_helper'

    game = Game.new

    game.main_menu

    game.cruiser_random_placement
    game.sub_random_placement
    game.board_user.render

    p "Your turn sailor! Place yer cruiser! Enter 3 coordinates to place your ship."

    game.player_cruiser_placement      
    game.board_user.render(true)

    p "Great job captain! next up, place your submarine! Only 2 coordinates for this one!"

    game.player_sub_placement
    game.board_user.render(true)

    p "Nice typing! now the game can begin!"

    game.turn


