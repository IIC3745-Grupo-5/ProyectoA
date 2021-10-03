# frozen_string_literal: true

require 'terminal-table'
require_relative './cell'
require_relative './constants/dimensions'
require_relative './constants/cell_type'
require_relative './constants/level'
require_relative './observer/observable'

# Class that creates a board object, which can display a minesweeper board
class Board < Observable
  attr_reader :matrix, :width, :number_of_mines, :number_of_flags

  def initialize(difficulty_level = Level::BEGGINER)
    super()
    @matrix = []
    @width, @height = Dimensions::BOARD[difficulty_level]
    @number_of_mines = Dimensions::MINES[difficulty_level]
    @number_of_flags = Dimensions::MINES[difficulty_level] # The number of flags is the same that the number of mines
    build
    mark_adjacent_mines
  end

  def build
    create_cell_array
    (0..@height).each do |row|
      row_array = []
      (0..@width).each do |col|
        random_cell_type = @cell_array.delete_at(rand(@cell_array.length))
        row_array << Cell.new(col, row, random_cell_type)
      end
      @matrix << row_array
    end
  end

  def create_cell_array
    safe_cells = (@width + 1) * (@height + 1) - @number_of_mines
    @cell_array = [CellType::SAFE] * safe_cells + [CellType::MINE] * @number_of_mines
  end

  def mark_adjacent_mines
    @matrix.each do |row|
      row.each do |cell|
        cell.mark_adjacent_mines(@matrix)
      end
    end
  end

  def discover_cell(x_coordinate, y_coordinate)
    cell = @matrix[y_coordinate][x_coordinate]
    return 'flagged' if cell.flagged

    cell.discovered = true
    cell.discover_empty_neighbors(@matrix) if cell.empty
    return 'explosion' if cell.type == CellType::MINE
  end

  def flag_cell(x_coordinate, y_coordinate)
    cell = @matrix[y_coordinate][x_coordinate]
    return 'discovered' if cell.discovered

    if cell.flagged == false
      return 'no_flags' if @number_of_flags.zero?

      cell.flagged = true
      @number_of_flags -= 1
    else
      cell.flagged = false
      @number_of_flags += 1
    end
  end

  def print
    rows = create_printable_board
    board = Terminal::Table.new rows: rows
    board.title = "                Mine Sweeper       🚩 Flags: #{@number_of_flags}"
    board.headings = ['y\x'].concat((0..@height).to_a)
    board.style = {
      border: Terminal::Table::UnicodeThickEdgeBorder.new,
      all_separators: true
    }
    @ui.print_console(board)
    rows
  end

  def create_printable_board
    printable_board = []
    @matrix.each_with_index do |row, index|
      formatted_row = [index]
      row.each do |cell|
        formatted_row << cell.print
      end
      printable_board << formatted_row
    end
    printable_board
  end

  def show_bombs
    @matrix.each do |row|
      row.each do |cell|
        cell.discovered = true if cell.type == CellType::MINE
      end
    end
  end

  def explode_bomb(y_coordinate, x_coordinate)
    cell = @matrix[y_coordinate][x_coordinate]
    cell.type = CellType::EXPLODED
  end
end
