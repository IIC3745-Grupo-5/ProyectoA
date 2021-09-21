# frozen_string_literal: true

require_relative './constants/cell_type'


class Cell
  def initialize(x, y, type)
    @x = x
		@y = y
		@type = type
		@discovered = false
  end

	def print
		@discovered ? @type : CellType::HIDDEN
	end
end
