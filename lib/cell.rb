# frozen_string_literal: true

require_relative './constants/cell_type'

# Class that creates an object representing a cell in the board
class Cell
  def initialize(x_coordinate, y_coordinate, type)
    @x = x_coordinate
    @y = y_coordinate
    @type = type
    @discovered = false
  end

  def print
    @discovered ? @type : CellType::HIDDEN
  end
end
