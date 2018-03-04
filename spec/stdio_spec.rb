require 'spec_helper'
require './stdio'

describe '#get_stdin' do
  it do
    fake_input 'hoge' do
    end
    get_stdin

    allow(STDIN).to receive(:gets) { 'joe' }

    expect(get_stdin).to eq 'hello'
  end
end

def fake_input(*args)
  begin
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end
end
