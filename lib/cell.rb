# frozen_string_literal: true

require_relative './constants/cell_type'

# Class that creates an object representing a cell in the board
class Cell
  attr_accessor :discovered

  def initialize(x_coordinate, y_coordinate, type)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @type = type
    @discovered = false
  end

  def print
    @discovered ? @type : CellType::HIDDEN
  end
end
