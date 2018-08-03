# frozen_string_literal: true

class Hoge
  def mew
    mew_from_protected
  end

  protected

  def mew_from_protected
    puts 'mewmew'
  end
end

class Fuga < Hoge
  def bow
    mew_from_protected
    # this does not raise an error
    self.mew_from_protected
  end
end

class Piyo
  def mew
    mew_from_private
  end

  private

  def mew_from_private
    puts 'mewmew'
  end
end

class Nyan < Piyo
  def bow
    mew_from_private

    # this raises an error
    # self.mew_from_private
  end
end

if $PROGRAM_NAME == __FILE__
  h = Hoge.new
  h.mew

  f = Fuga.new
  f.bow

  p = Piyo.new
  p.mew

  n = Nyan.new
  n.bow
end
