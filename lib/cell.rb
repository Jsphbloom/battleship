class Cell
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        if @ship == nil
            return true
        else
            return false
        end
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        if @ship == nil
            @fired_upon = true 
        else @ship.sunk? == false
            @fired_upon = true
            @ship.hit
        end
    end

    def render(debug = false)
        if debug == true && @ship != nil
            return "S"
        elsif fired_upon? == true && @ship == nil
            return "M"
        elsif fired_upon? == true && @ship != nil && @ship.sunk? == true
            return "X"
        elsif fired_upon? == true && @ship != nil
            return "H"
        else
            return "."
        end
    end
end