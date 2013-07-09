define ['deck', 'player'], (Deck, Player) ->
  class Cribbage
    constructor: ->
      @players = []
      @deck = new Deck()
