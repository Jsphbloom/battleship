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
            p "Coordinate already hit."
        end
    end

    def render(debug = false)
        if fired_upon? == true && @ship == nil
            return "M"
        elsif fired_upon? == true && @ship != nil && @ship.sunk? == true
            return "X"
        elsif fired_upon? == true && @ship != nil
            return "H"
        elsif debug == true && @ship != nil
            return "S"
        else
            return "."
        end
    end
end