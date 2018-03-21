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
        context 'alive -> alive' do
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

        context 'alive -> dead' do
          before do
            lifegame.lifes[4][4] = 1

            lifegame.lifes[4][5] = 1
            lifegame.lifes[3][4] = 1
            lifegame.lifes[3][3] = 1
            lifegame.lifes[5][4] = 1
          end

          it do
            lifegame.next_life(4, 4)

            expect(lifegame.next_lifes[4][4]).to eq 0
          end
        end

        context 'dead -> alive' do
          before do
            lifegame.lifes[4][4] = 0

            lifegame.lifes[4][5] = 1
            lifegame.lifes[3][4] = 1
            lifegame.lifes[3][3] = 1
          end

          it do
            lifegame.next_life(4, 4)

            expect(lifegame.next_lifes[4][4]).to eq 1
          end
        end

        context 'dead -> dead' do
          before do
            lifegame.lifes[4][4] = 0

            lifegame.lifes[4][5] = 1
            lifegame.lifes[3][4] = 1
          end

          it do
            lifegame.next_life(4, 4)

            expect(lifegame.next_lifes[4][4]).to eq 0
          end
        end
      end

      describe 'corner of lifegame' do
        context 'alive -> alive' do
          before do
            lifegame.lifes[0][0] = 1

            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
          end

          it do
            lifegame.next_life(0, 0)

            expect(lifegame.next_lifes[0][0]).to eq 1
          end
        end

        context 'alive -> dead' do
          before do
            lifegame.lifes[0][0] = 1

            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
            lifegame.lifes[7][0] = 1
            lifegame.lifes[0][1] = 1
          end

          it do
            lifegame.next_life(0, 0)

            expect(lifegame.next_lifes[0][0]).to eq 0
          end
        end

        context 'dead -> alive' do
          before do
            lifegame.lifes[0][0] = 0

            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
            lifegame.lifes[7][0] = 1
          end

          it do
            lifegame.next_life(0, 0)

            expect(lifegame.next_lifes[0][0]).to eq 1
          end
        end

        context 'dead -> dead' do
          before do
            lifegame.lifes[0][0] = 0

            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
          end

          it do
            lifegame.next_life(0, 0)

            expect(lifegame.next_lifes[0][0]).to eq 0
          end
        end
      end
    end

    describe '#count_surround_lifes' do
      describe 'middle of lifegame' do
        subject { lifegame.count_surround_lifes(4, 4) }

        context 'no lifes' do
          it { is_expected.to eq 0 }
        end

        context 'some lifes' do
          before do
            lifegame.lifes[3][4] = 1
            lifegame.lifes[4][3] = 1
            lifegame.lifes[5][4] = 1
            lifegame.lifes[4][5] = 1
          end

          it { is_expected.to eq 4 }
        end

        context 'some lifes stand in horizontal line' do
          before do
            lifegame.lifes[3][3] = 1
            lifegame.lifes[4][3] = 1
            lifegame.lifes[5][3] = 1
          end

          it { is_expected.to eq 3 }
        end

        context 'some lifes with center is alive' do
          before do
            lifegame.lifes[4][4] = 1

            lifegame.lifes[3][4] = 1
            lifegame.lifes[4][3] = 1
            lifegame.lifes[5][4] = 1
            lifegame.lifes[4][5] = 1
          end

          it { is_expected.to eq 4 }
        end

        context 'some lifes stand in horizontal line with its center is alive' do
          before do
            lifegame.lifes[4][4] = 1

            lifegame.lifes[3][3] = 1
            lifegame.lifes[4][3] = 1
            lifegame.lifes[5][3] = 1
          end

          it { is_expected.to eq 3 }
        end
      end

      describe 'corner of lifegame' do
        subject { lifegame.count_surround_lifes(0, 0) }

        context 'no lifes' do
          it { is_expected.to eq 0 }
        end

        context 'some lifes' do
          before do
            lifegame.lifes[0][1] = 1
            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
            lifegame.lifes[7][0] = 1
          end

          it { is_expected.to eq 4 }
        end

        context 'some lifes with its center is alive' do
          before do
            lifegame.lifes[0][0] = 1

            lifegame.lifes[7][7] = 1
            lifegame.lifes[0][7] = 1
            lifegame.lifes[7][0] = 1
          end

          it { is_expected.to eq 3 }
        end
      end
    end
  end
end
