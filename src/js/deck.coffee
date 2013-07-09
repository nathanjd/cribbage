define ['card'], (Card) ->
  # public interface
  class Deck
    # returns a standard deck of 52 cards.
    constructor: ->
      @cards = []
      cards = @cards
      # fill the deck
      for suit in Card::suits()
        do (suit) ->
          cards.push(
            new Card(value + suit)
          ) for value in Card::values()

    draw: -> @cards.pop()

    shuffle: ->
      randomlySwap = (index) ->
        target = Math.floor(Math.random() * @cards.length)
        swap = @cards[target]

        @cards[target] = @cards[index]
        @cards[index] = swap

      randomlySwap i for i in [0...@cards.length]
