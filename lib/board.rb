require './spec/spec_helper'
require 'rainbow/refinement'
using Rainbow

class Board
    attr_reader :cells

    def initialize(height, width)
        @cells = {}
        @height = height
        @width = width
        ("A"...("A".ord + height).chr).each do |row|
            (1..width).each do |col|
                coordinate = "#{row}#{col}"
                @cells[coordinate] = Cell.new(coordinate)
            end
        end
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
        if valid_placement?(ship, coordinates) == true
            coordinates.each do |coordinate|
                @cells[coordinate].place_ship(ship)
            end
            true
        else 
            false
        end
    end
    
    def render(debug = false)
        if debug == false
        
            top_nums = (1..@width).to_a.join(separator = " ")
            puts "  #{top_nums}"
            @cells.values.each_slice(@width).with_index do |row, index|
                rendered_row = row.map(&:render).join(" ")
                puts "#{('A'.ord + index).chr} #{rendered_row}"
            end
        else
            top_nums = (1..@width).to_a.join(separator = " ")
            puts "  #{top_nums}"
            @cells.values.each_slice(@width).with_index do |row, index|
                rendered_row = row.map { |cell|
                    cell.render(true) }.join(" ")
                puts "#{('A'.ord + index).chr} #{rendered_row}"
            end
        end
        
    end

end