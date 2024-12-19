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
        @fired_upon = true
        if @ship == nil
            return "Miss."   
        else @ship.sunk? == false
            @ship.hit
            return "Ship has been hit."
        end
    end
end