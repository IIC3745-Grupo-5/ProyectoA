# frozen_string_literal: true

# Class for creating an observer object following the observer desgin pattern
class Observer
  def update(*)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
