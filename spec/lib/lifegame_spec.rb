require 'spec_helper'
require 'lifegame'

RSpec.describe 'Lifegame' do
  describe '#initialize' do
    context 'with no condition' do
      subject { Lifegame.new.lifes }

      it { is_expected.to eq [
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0]
                             ] }
    end

    context 'size == 4' do
      subject { Lifegame.new(4).lifes }

      it { is_expected.to eq [
                              [0, 0, 0, 0],
                              [0, 0, 0, 0],
                              [0, 0, 0, 0],
                              [0, 0, 0, 0]
                             ] }
    end
  end

  describe 'instance methods' do
    let(:lifegame) { Lifegame.new }

    describe '#next_life' do
      describe 'middle of lifegame' do
        context 'live -> live' do
          before do
            lifegame.lifes[4][4] = 1

            lifegame.lifes[4][5] = 1
            lifegame.lifes[3][4] = 1
          end

          it do
            lifegame.next_life(4, 4)

            expect(lifegame.next_lifes[4][4]).to eq 1
          end
        end
      end

      describe 'corner of lifegame' do
      end
    end

    describe '#count_surround_lives' do
      describe 'middle of lifegame' do
        subject { lifegame.count_surround_lives(4, 4) }

        context 'no lives' do
          it { is_expected.to eq 0 }
        end

        context 'some lives' do
          before do
            lifegame.lifes[3][4] = 1
            lifegame.lifes[4][3] = 1
            lifegame.lifes[5][4] = 1
            lifegame.lifes[4][5] = 1
          end

          it { is_expected.to eq 4 }
        end
      end

      describe 'corner of lifegame' do
        subject { lifegame.count_surround_lives(0, 0) }

        context 'no lives' do
          it { is_expected.to eq 0 }
        end

        context 'some lives' do
          before do
            lifegame.lifes[0][1] = 1
            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
            lifegame.lifes[7][0] = 1
          end

          it { is_expected.to eq 4 }
        end
      end
    end
  end
end
