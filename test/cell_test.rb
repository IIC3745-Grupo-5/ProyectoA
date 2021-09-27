# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/cell'
require_relative '../lib/constants/cell_type'
require 'test/unit'

class CellTest < Test::Unit::TestCase
  def test_print_undiscovered
    cell = Cell.new(3, 4, CellType::HIDDEN)
    output = cell.print
    assert_equal(CellType::HIDDEN, output)
  end

  def test_print_flagged
    cell = Cell.new(3, 2, CellType::FLAGGED)
    cell.flagged = true
    output = cell.print
    assert_equal(CellType::FLAGGED, output)
  end

  def test_print_safe_not_empty
    cell = Cell.new(6, 2, CellType::SAFE)
    cell.adjacent_mines = 2
    cell.discovered = true
    output = cell.print
    assert_equal(2, output)
  end

  def test_print_discovered_eq
    cell = Cell.new(1, 7, CellType::MINE)
    cell.discovered = true
    output = cell.print
    assert_equal(CellType::MINE, output)
  end

  def test_print_discovered_neq
    cell = Cell.new(5, 0, CellType::SAFE)
    cell.discovered = true
    cell.adjacent_mines = 0
    output = cell.print
    assert_not_equal(CellType::MINE, output)
  end
end
