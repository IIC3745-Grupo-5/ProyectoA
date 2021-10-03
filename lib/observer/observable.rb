# frozen_string_literal: true

require_relative '../ui'

# Class for creating an observable object following the observer desgin pattern
class Observable
  def initialize
    @observers = []
    @ui = Ui.new
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_all
    @observers.each { |observer| observer.update(self) }
  end
end
