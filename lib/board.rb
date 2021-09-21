# frozen_string_literal: true

require_relative './cell'
require_relative './constants/dimensions'
require_relative './constants/cell_type'
require_relative './constants/difficulty_type'
require_relative './observer/observable'


class Board < Observable
	def initialize(difficulty_level = DifficultyType::BEGGINER)
		super()
		@matrix = []
		@width, @height = Dimensions::BOARD[difficulty_level]
		@number_of_mines = Dimensions::MINES[difficulty_level]
		build()
	end

	def build
		for row in (0..@height)
			row_array = []
			for col in (0..@width)
				row_array << Cell.new(col, row, CellType::SAFE)
			end
			@matrix << row_array
		end
	end

	def print
		print_horizontal_line
		for row in @matrix
			row_to_display = '|'
			for cell in row
				row_to_display += cell.print + '|'
			end
			puts row_to_display
		end
		print_horizontal_line
	end

	def print_horizontal_line
		puts '-' + '--' * @width + '-'
	end
end
