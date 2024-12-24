require './spec/spec_helper'

class Board
    attr_reader :cells

    def initialize
       @cells = {"A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")}
    end

    def valid_coordinate?(coordinate)
        @cells.has_key?(coordinate)
    end

    def valid_coordinates?(coordinates)
        coordinates.all? do |coordinate|
            valid_coordinate?(coordinate)
        end
    end

    def coordinates_empty?(coordinates)
        coordinates.all? do |coordinate|
            @cells[coordinate].empty?
        end
    end
    
    def valid_placement?(ship, coordinates)
        if coordinates.length == ship.length && 
            same_letters?(coordinates) &&
            consecutive_numbers?(coordinates) &&
            valid_coordinates?(coordinates) &&
            coordinates_empty?(coordinates)
            true
        elsif coordinates.length == ship.length && 
            consecutive_letters?(coordinates) &&
            same_numbers?(coordinates)&&
            valid_coordinates?(coordinates) &&
            coordinates_empty?(coordinates)
            true
        else
            false
        end
    end

    def consecutive_letters?(coordinates)
        coordinates.each_cons(2).all? do |coordinate|
            coordinate[0].ord + 1 == coordinate[1].ord
        end
    end

    def consecutive_numbers?(coordinates)
        coordinates.each_cons(2).all? do |coordinate|
            coordinate[0].chars[1].to_i + 1 == coordinate[1].chars[1].to_i
        end
    end

    def same_letters?(coordinates)
        coordinates.each_cons(2).all? do |coordinate|
            coordinate[0].ord == coordinate[1].ord
        end
    end

    def same_numbers?(coordinates)
        coordinates.each_cons(2).all? do |coordinate|
            coordinate[0].chars[1].to_i == coordinate[1].chars[1].to_i
        end
    end

    def place(ship, coordinates)
        valid_placement?(ship, coordinates)
        coordinates.each do |coordinate|
            @cells[coordinate].place_ship(ship)
        end
        # binding.pry
    end

end