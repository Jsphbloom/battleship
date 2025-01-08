require 'rainbow/refinement'
using Rainbow

class Cell
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        if @ship == nil && @fired_upon == false
            @fired_upon = true
        elsif @ship != nil && @ship.sunk? == false && @fired_upon == false
            @fired_upon = true
            @ship.hit
        else 
            puts Rainbow("Coordinate already hit.").bright.red
        end
    end

    def render(debug = false)
        if fired_upon? == true && @ship == nil
            return Rainbow("M").yellow
        elsif fired_upon? == true && @ship != nil && @ship.sunk? == true #can write as !ship
            return Rainbow("X").red
        elsif fired_upon? == true && @ship != nil
            return Rainbow("H").orange
        elsif debug == true && @ship != nil
            return Rainbow("S").limegreen
        else
            return Rainbow(".").blue
        end
    end
end