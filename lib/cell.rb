# frozen_string_literal: true

require_relative './constants/cell_type'

# Class that creates an object representing a cell in the board
class Cell
  attr_accessor :discovered, :adjacent_mines, :flagged, :type

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
        out_of_range(row_diff, col_diff) && next
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

  def discover_empty_neighbors(matrix)
    @discovered = true
    (-1..1).each do |row_diff|
      (-1..1).each do |col_diff|
        out_of_range(row_diff, col_diff) && next
        neighbor_cell = matrix[@y_coordinate + row_diff][@x_coordinate + col_diff]
        check_if_neighbor_empty(matrix, neighbor_cell)
      rescue NoMethodError
        next
      end
    end
  end

  def check_if_neighbor_empty(matrix, cell)
    return if cell.discovered

    cell.discovered = true if cell.adjacent_mines.positive?
    cell.discover_empty_neighbors(matrix) if cell.empty
  end

  def out_of_range(row_diff, col_diff)
    (@y_coordinate + row_diff).negative? or (@x_coordinate + col_diff).negative?
  end

  def empty
    @type == CellType::SAFE && @adjacent_mines.zero?
  end

  def show_discovered
    return @type if empty || @type == CellType::MINE

    @adjacent_mines
  end

  def print
    return CellType::FLAGGED if @flagged

    return CellType::HIDDEN unless @discovered

    show_discovered
  end
end
