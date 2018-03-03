require 'nqueen'

RSpec.describe NQueen do
  let(:nqueen) { NQueen.new }

  describe '#checker' do
    subject { nqueen.checker board }

    context 'true' do
      let(:board) { [1, 3, 0, 2] }

      it { is_expected.to eq true }
    end

    context 'false' do
      let(:board) { [1, 2, 3, 0] }

      it { is_expected.to eq false }
    end
  end
end
