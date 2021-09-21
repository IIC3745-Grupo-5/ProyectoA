# frozen_string_literal: true

require_relative './observer/observable'
require 'matrix'


class Board < Observable
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
                    row.push(" ")
                end
            end
            
            @matrix.push(row)
        end
        @matrix[0][0] = " "
    end
    
end

    