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

class Game
    attr_accessor :wallet, :hand, :shoe, :total, :h_hand, :h_total

    def initialize(wallet)
        @wallet = wallet
        @shoe = Deck.new
            @shoe.shuffle
        @hand = []
        @total = 0
        @h_hand = []
        @h_total = 0
    end

    def bet
        @wallet > 9 ? (puts "You have $#{@wallet} and bet $10.") : (puts "You are out of money.")
    end

    def new_hand
        2.times { @hand.push(@shoe.deal) }
        player_total
    end

    def total_result
        ranks = @hand.map { |y| y.rank }
        puts "You have #{ranks.join(", ")} in your hand. Your total is #{@total}."
    end

    def player_total
        @total = 0
        @total = @hand.inject(0){ |sum,v| sum + v.value }
        if @total > 21
            total_result
            puts "You bust!"
            lose_ten
        else 
            total_result
            hit_or_stay
        end
    end

    def dealer_total
        @h_total = 0
        @h_total = @h_hand.inject(0){ |sum,v| sum + v.value }
        if @h_total > 21
            puts "The dealer's total is #{@h_total}. You win!\n\n----\n\n"
            win_ten
            return
        elsif @h_total > 17
            puts "The dealer stands. The dealer has a total of #{@h_total}."
            round_result
        else
            dealer_hit
        end
    end

    def hit
        @hand.push(@shoe.deal)
        player_total
    end
    
    def hit_or_stay
        while true
            puts "Do you want to (h)it or (s)tand?"
            answer = gets.chomp.downcase
            if answer[0] == "h"
                print "You hit."
                hit
                return
            elsif answer[0] == "s"
                print "You stand. Your total is #{@total}, "
                dealer
                return
            else
                puts "That is not a valid answer!"
            end
        end
    end

    def dealer_hit
        puts "The dealer hits."
        @h_hand.push(@shoe.deal)
        dealer_total
    end

    def round_result
        if @total > @h_total
            puts "You win!"
            win_ten
            return
        elsif @total < @h_total
            puts "You lose!"
            lose_ten
            return
        else
            puts "It's a tie!"
            new_round
            return
        end
    end

    def dealer
        2.times { @h_hand.push(@shoe.deal) }
        dealer_total 
    end

    def lose_ten
        @wallet = @wallet - 10
        new_round
    end

    def win_ten
        @wallet = @wallet + 10
        new_round
    end

    def new_round
        @hand = []
        @total = 0
        @h_hand = []
        @h_total = 0
        @shoe = Deck.new
            @shoe.shuffle
    end

    def start_game
        puts "Welcome to blackjack! Let's begin"
        while @wallet > 9
            bet
            new_hand
        end
    end

end

play = Game.new(100)
play.start_game