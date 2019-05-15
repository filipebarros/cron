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

  shared_examples 'regexes' do
    subject(:handler) { described_class.handle(string, type) }

    describe 'when string is `*`' do
      let(:string) { '*' }

      it 'lists all values in range' do
        expect(handler).to eq((minimum..maximum).to_a)
      end
    end

    describe 'when string is `*/3`' do
      let(:string) { '*/3' }

      it 'lists all values with 3 as the step' do
        expect(handler).to eq((minimum..maximum).step(3).to_a)
      end
    end

    describe 'when string is `2-5`' do
      let(:string) { '2-5' }

      it 'lists all values from 2 to 5' do
        expect(handler).to eq([2, 3, 4, 5])
      end
    end

    describe 'when string is `1,3,4`' do
      let(:string) { '1,3,4' }

      it 'lists all values passed to the method' do
        expect(handler).to eq([1, 3, 4])
      end
    end
  end

  describe 'minute' do
    it_behaves_like 'regexes' do
      let(:type) { :minute }
      let(:minimum) { 0 }
      let(:maximum) { 59 }
    end
  end

  describe 'hour' do
    it_behaves_like 'regexes' do
      let(:type) { :hour }
      let(:minimum) { 0 }
      let(:maximum) { 23 }
    end
  end

  context 'with day of the month' do
    it_behaves_like 'regexes' do
      let(:type) { :day_of_the_month }
      let(:minimum) { 1 }
      let(:maximum) { 31 }
    end
  end

  context 'with month' do
    it_behaves_like 'regexes' do
      let(:type) { :month }
      let(:minimum) { 1 }
      let(:maximum) { 12 }
    end
  end

  context 'with day of the week' do
    it_behaves_like 'regexes' do
      let(:type) { :day_of_the_week }
      let(:minimum) { 1 }
      let(:maximum) { 7 }
    end
  end
end
