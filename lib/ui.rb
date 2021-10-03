# frozen_string_literal: true

require 'highline/import'

# Class who ui inputs and prints
class Ui
  @input = new

  class << self
    attr_reader :input
  end

  def print_console(input)
    puts input
  end

  def say(input = '')
    say(input)
  end
end
