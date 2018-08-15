class Deck

    attr_accessor :deck

    SUITS = [ :diamond, :heart, :spade, :club ]
    RANKS = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]

    def initialize
        @deck = []
        new_deck
    end

    def new_deck
        SUITS.each do |suit|
            RANKS.map do |rank|
                @deck.push (Card.new(rank, suit))
            end
        end 
    end

    def deal
        @deck.shift
    end

    def shuffle
        @deck.shuffle!
    end

    def cards_left
        @deck.length
    end
end

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
            else
                 nil
            end
    end
end

