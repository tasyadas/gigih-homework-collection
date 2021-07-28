require_relative './integer_arr_incrementer'

RSpec.describe IntegerArrIncrementer do
    context '#increment' do
        it 'should return [1] when input is [0]' do
            input = [0]
            expected_output = [1]

            actual_output = IntegerArrIncrementer.new.increment(input)
            expect(actual_output).to eq(expected_output)
        end
end