# frozen_string_literal: true

require_relative './constants/cell_type'

# Class that creates an object representing a cell in the board
class Cell
  attr_accessor :discovered, :adjacent_mines
  attr_reader :type

  def initialize(x_coordinate, y_coordinate, type, adjacent_mines = nil)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @type = type
    @discovered = false
    @adjacent_mines = adjacent_mines
  end

  def mark_adjacent_mines(matrix)
    unless @type == CellType::MINE
      number_adjacent_mines = 0
      (-1..1).each do |row_diff|
        (-1..1).each do |col_diff|
          begin
            adjacent_cell = matrix[@y_coordinate + row_diff][@x_coordinate + col_diff]
            number_adjacent_mines += adjacent_cell.type == CellType::MINE ? 1 : 0
          rescue
            # Do Nothing jeje
          end
        end
      end
      @adjacent_mines = number_adjacent_mines
    end
  end

  def print
    to_display = @type == CellType::MINE ? @type : @adjacent_mines
    @discovered ? to_display : CellType::HIDDEN
  end
end
