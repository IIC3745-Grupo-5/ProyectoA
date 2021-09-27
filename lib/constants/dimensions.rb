# frozen_string_literal: true

module Dimensions
  BOARD = {
    'BEGGINER' => [7, 7], # 8x8
    'INTERMEDIATE' => [11, 11], # 12x12
    'EXPERT' => [15, 15] # 16x16
  }.freeze

  MINES = {
    'BEGGINER' => 12, # 18%
    'INTERMEDIATE' => 36, # 25%
    'EXPERT' => 92 # 36%
  }.freeze
end
