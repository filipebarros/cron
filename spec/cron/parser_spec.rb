RSpec.describe Cron::Parser do
  context 'parse' do
    subject(:parser) { described_class.parse(*arguments) }

    let(:arguments) { [minute, hour, day_of_the_month, month, day_of_the_week,  command] }

    let(:minute) { '*' }
    let(:hour) { '*' }
    let(:day_of_the_month) { '*' }
    let(:month) { '*' }
    let(:day_of_the_week) { '*' }
    let(:command) { '/usr/bin/test' }

    let(:expected_result) do
      {
        minute: (0..59).to_a,
        hour: (0..23).to_a,
        day_of_the_month: (1..31).to_a,
        month: (1..12).to_a,
        day_of_the_week: (1..7).to_a,
        command: '/usr/bin/test'
      }
    end

    it 'compiles all data for all commands in a hash' do
      expect(parser).to eq(expected_result)
    end
  end

  describe '#handle' do
    subject(:handler) { described_class.handle(string, type) }

    context 'with minute' do
      let(:type) { :minute }

      describe 'when string is `*`' do
        let(:string) { '*' }

        it 'lists all minutes from 0 to 59' do
          expect(handler).to eq((0..59).to_a)
        end
      end

      describe 'when string is `*/10`' do
        let(:string) { '*/10' }

        it 'lists all minutes with 10 as the step' do
          expect(handler).to eq([0, 10, 20, 30, 40, 50])
        end
      end

      describe 'when string is `7-10`' do
        let(:string) { '7-10' }

        it 'lists all minutes from 7 to 10' do
          expect(handler).to eq([7, 8, 9, 10])
        end
      end

      describe 'when string is `10,15,16`' do
        let(:string) { '10,15,16' }

        it 'lists all minutes passed to the method' do
          expect(handler).to eq([10, 15, 16])
        end
      end
    end

    context 'with hour' do
      let(:type) { :hour }

      describe 'when string is `*`' do
        let(:string) { '*' }

        it 'lists all hours from 0 to 23' do
          expect(handler).to eq((0..23).to_a)
        end
      end

      describe 'when string is `*/10`' do
        let(:string) { '*/10' }

        it 'lists all hours with 10 as the step' do
          expect(handler).to eq([0, 10, 20])
        end
      end

      describe 'when string is `7-10`' do
        let(:string) { '7-10' }

        it 'lists all hours from 7 to 10' do
          expect(handler).to eq([7, 8, 9, 10])
        end
      end

      describe 'when string is `10,15,16`' do
        let(:string) { '10,15,16' }

        it 'lists all hours passed to the method' do
          expect(handler).to eq([10, 15, 16])
        end
      end
    end

    context 'with day of the month' do
      let(:type) { :day_of_the_month }

      describe 'when string is `*`' do
        let(:string) { '*' }

        it 'lists all days of the month from 1 to 31' do
          expect(handler).to eq((1..31).to_a)
        end
      end

      describe 'when string is `*/10`' do
        let(:string) { '*/10' }

        it 'lists all days of the month with 10 as the step' do
          expect(handler).to eq([1, 11, 21, 31])
        end
      end

      describe 'when string is `7-10`' do
        let(:string) { '7-10' }

        it 'lists all days of the month from 7 to 10' do
          expect(handler).to eq([7, 8, 9, 10])
        end
      end

      describe 'when string is `10,15,16`' do
        let(:string) { '10,15,16' }

        it 'lists all days of the month passed to the method' do
          expect(handler).to eq([10, 15, 16])
        end
      end
    end

    context 'with month' do
      let(:type) { :month }

      describe 'when string is `*`' do
        let(:string) { '*' }

        it 'lists all month from 1 to 12' do
          expect(handler).to eq((1..12).to_a)
        end
      end

      describe 'when string is `*/4`' do
        let(:string) { '*/4' }

        it 'lists all months with 4 as the step' do
          expect(handler).to eq([1, 5, 9])
        end
      end

      describe 'when string is `7-10`' do
        let(:string) { '7-10' }

        it 'lists months from 7 to 10' do
          expect(handler).to eq([7, 8, 9, 10])
        end
      end

      describe 'when string is `6,8,10`' do
        let(:string) { '6,8,10' }

        it 'lists all days of the month passed to the method' do
          expect(handler).to eq([6, 8, 10])
        end
      end
    end

    context 'with day of the week' do
      let(:type) { :day_of_the_week }

      describe 'when string is `*`' do
        let(:string) { '*' }

        it 'lists all days of the week from 1 to 7' do
          expect(handler).to eq((1..7).to_a)
        end
      end

      describe 'when string is `*/2`' do
        let(:string) { '*/2' }

        it 'lists all days of the week with 2 as the step' do
          expect(handler).to eq([1, 3, 5, 7])
        end
      end

      describe 'when string is `4-7`' do
        let(:string) { '4-7' }

        it 'lists months from 4 to 7' do
          expect(handler).to eq([4, 5, 6, 7])
        end
      end

      describe 'when string is `3,5,7`' do
        let(:string) { '3,5,7' }

        it 'lists all days of the month passed to the method' do
          expect(handler).to eq([3, 5, 7])
        end
      end
    end
  end
end
