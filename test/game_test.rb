# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/constants/level'
require_relative '../lib/constants/cell_type'
require_relative '../lib/constants/dimensions'
require 'test/unit'

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_win_condition
    @game.board.matrix.each do |row|
      row.each do |cell|
        cell.type = CellType::SAFE
        cell.discovered = true
      end
    end
    @game.win_check
    win = @game.playing
    assert_equal(false, win)
  end
end
