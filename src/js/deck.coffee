define ['card'], (Card) ->
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

    shuffle: -> @cards = _.shuffle @cards
