# frozen_string_literal: true

require 'terminal-table'
require_relative './cell'
require_relative './constants/dimensions'
require_relative './constants/cell_type'
require_relative './constants/difficulty_type'
require_relative './observer/observable'

# Class that creates a board object, which can display a minesweeper board
class Board < Observable
  def initialize(difficulty_level = DifficultyType::BEGGINER)
    super()
    @matrix = []
    @width, @height = Dimensions::BOARD[difficulty_level]
    @number_of_mines = Dimensions::MINES[difficulty_level]
    setup
  end

  def setup
    create_cell_array
    build
  end

  def build
    (0..@height).each do |row|
      row_array = []
      (0..@width).each do |col|
        row_array << Cell.new(col, row, random_cell_type)
      end
      @matrix << row_array
    end
  end

  def create_cell_array
    safe_cells = (@width + 1) * (@height + 1) - @number_of_mines
    @cell_array = [CellType::SAFE] * safe_cells + [CellType::MINE] * @number_of_mines
  end

  def random_cell_type
    @cell_array.delete_at(rand(@cell_array.length))
  end

  def print
    rows = create_printable_board
    board = Terminal::Table.new rows: rows
    board.title = 'Mine Sweeper'
    board.headings = ['y\x'].concat((0..@height).to_a)
    board.style = {
      border: Terminal::Table::UnicodeThickEdgeBorder.new,
      all_separators: true
    }
    puts board
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
end
