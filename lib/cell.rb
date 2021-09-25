# frozen_string_literal: true

require_relative './constants/cell_type'

# Class that creates an object representing a cell in the board
class Cell
  attr_accessor :discovered, :adjacent_mines, :flagged
  attr_reader :type

  def initialize(x_coordinate, y_coordinate, type, adjacent_mines = nil)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @type = type
    @discovered = false
    @adjacent_mines = adjacent_mines
    @flagged = false
  end

  def mark_adjacent_mines(matrix)
    return if @type == CellType::MINE

    @adjacent_mines = 0
    (-1..1).each do |row_diff|
      (-1..1).each do |col_diff|
        ((@y_coordinate + row_diff).negative? or (@x_coordinate + col_diff).negative?) && next
        check_neighbor(matrix, row_diff, col_diff)
      rescue NoMethodError
        next
      end
    end
  end

  def check_neighbor(matrix, row_diff, col_diff)
    adjacent_cell = matrix[@y_coordinate + row_diff][@x_coordinate + col_diff]
    @adjacent_mines += adjacent_cell.type == CellType::MINE ? 1 : 0
  end

  def print
    if @flagged
      return CellType::FLAGGED
    end
    to_display = @type == CellType::MINE ? @type : @adjacent_mines
    @discovered ? to_display : CellType::HIDDEN
  end
end
