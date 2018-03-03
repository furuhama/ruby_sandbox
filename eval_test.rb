#!/usr/bin/env ruby

def basic_eval
  eval "p 'hoge'"
end

class Language
  def initialize(options={})
    options.each do |name, value|
      eval "@#{name} = '#{value}'"
      eval "def #{name}; @#{name};end"
    end
  end

  def my_define(options={})
    options.each do |name, value|
      eval <<-EOS
        def print_#{name}
          p '#{value}'
        end
      EOS
    end
  end
end

class Piyo; end

p1 = Piyo.new
p2 = Piyo.new

p1.instance_eval do
  def oden
    p 'oden tabetai'
  end
end

Piyo.class_eval do
  def roar
    p 'ugaaaa'
  end
end

class SecretInfo
  private

  def details
    'REALLY SECRET'
  end
end

def books(prefix)
  lambda {|titles| titles.map {|title| "#{prefix} #{title}" } }
end

if __FILE__ == $0
  ll = Language.new({haskell: 'functional'})
  p ll.haskell
  ll.my_define({ruby: 'object-oriented'})
  ll.print_ruby

  p1.oden
  # p2.oden

  p1.roar
  p2.roar

  s = SecretInfo.new
  p s.instance_eval { details }

  my_book_maker = books "Effective"
  p my_book_maker.call ["C++", "Ruby"]
end
