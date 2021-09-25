# frozen_string_literal: true

module Dimensions
  BOARD = {
    'BEGGINER' => [7, 7], # 8x8
    'INTERMEDIATE' => [11, 11], # 12x12
    'EXPERT' => [15, 15] # 16x16
  }.freeze

  MINES = {
    'BEGGINER' => 5, # 8%
    'INTERMEDIATE' => 11, # 8%
    'EXPERT' => 18 # 8%
  }.freeze
end
