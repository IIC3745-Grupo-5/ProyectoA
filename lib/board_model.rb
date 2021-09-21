# frozen_string_literal: true

require_relative './observer/observable'
require 'matrix'

class Cell 

    def initialize (x0,y0, type)
        @x = x0
        @y = y0
        @type = type
        @touched = 0
    end
end

class Board < Observable
## lo pense con un largo variable, en este caso deje como largo predeterminado 6x6
    def initialize(width = 5, height = 5)
        super()
        @matrix = []
        build(width, height)
    end
    
    def build(width, height)
        for numberRow in (0..height + 1)
            row = [numberRow-1]        
            for col in (0..width)
                if numberRow == 0 then
                    row.push(col)
                else
                    row.push(Cell.new(numberRow - 1,col, " "))
                end
            end
            
            @matrix.push(row)
        end
        @matrix[0][0] = " "
    end
    

end

    