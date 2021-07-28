class IntegerArrIncrementer
    def increment(input)
        input = [input.last + 1]

        if (input.last % 10) == 0
            input[-1] = 0
            increment(input.slice(0, input.length()))
        else
            return input
        end
    end
end