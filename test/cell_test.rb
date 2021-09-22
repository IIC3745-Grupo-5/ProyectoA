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

  def test_print_discovered_eq
    cell = Cell.new(3, 4, CellType::MINE)
    cell.discovered = true
    output = cell.print
    assert_equal(CellType::MINE, output)
  end

  def test_print_discovered_neq
    cell = Cell.new(3, 4, CellType::SAFE)
    cell.discovered = true
    output = cell.print
    assert_not_equal(CellType::MINE, output)
  end
end
