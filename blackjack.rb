class Card
    attr_accessor :rank, :suit, :value

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
        @value = value
    end

    def value 
        @value = case @rank
            when :A
                11
            when 2..10
                @rank
            when :J
                10
            when :Q
                10
            when :K
                10
            end
    end
end