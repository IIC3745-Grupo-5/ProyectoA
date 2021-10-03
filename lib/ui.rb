# frozen_string_literal: true

require 'highline/import'

# Class who ui inputs and prints
class Ui
  @input = new

  private_class_method :new

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
