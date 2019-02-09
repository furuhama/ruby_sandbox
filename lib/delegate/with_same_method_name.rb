# frozen_string_literal: true

require 'forwardable'

class ParentCat
  def mew
    puts 'mew from parent'
  end
end

class ChildCat
  extend Forwardable

  delegate mew: :@delegator

  def initialize
    @delegator = ParentCat.new
  end

  def mew
    puts 'mew from child'
  end
end

child_cat = ChildCat.new
child_cat.mew # mew from child
