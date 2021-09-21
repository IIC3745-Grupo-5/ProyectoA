# frozen_string_literal: true

require_relative './board'
require_relative './constants/difficulty_type'

board = Board.new(DifficultyType::INTERMEDIATE)
board.print
