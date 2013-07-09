define ['underscore', 'deck', 'player'], (_, Deck, Player) ->
  class Cribbage
    worth =
      'A': 1, '2': 2,  '3': 3,   '4': 4,  '5': 5,  '6': 6, '7': 7,
      '8': 8, '9': 9,  '10': 10, 'J': 10, 'Q': 10, 'K': 10

    order = ['A' '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

    isConnected = (cardA, cardB) ->
      # pairs and adjacent cards are considered connected
      _.contains [cardB - 1, cardB, cardB + 1] cardA

    # returns true if a card is connected to any in a given set
    connectionIn = (arr, card) ->
      connections = isConnected card, other for other in arr
      _.contains connections true
    constructor: ->
      @players = []
      @deck = new Deck()

    addPlayer: (name) ->
      @players.push(new Player(name))

    newGame: ->
      @deck = new Deck()

      # empty all players' points and hands

    deal: ->
      # retrieve cards from players

      # shuffle the deck
      @deck.shuffle()

      # deal 6 cards to each player

      # flip card, giving 2 points to player with priority if jack revealed

    # returns 2 points for each set of cards whose worth total 15 in a hand
    fifteens: (hand) ->

    # returns 1 point for every card in a run spanning at least 3 in a hand
    #   hand                    points 
    #   run of 3              = 1x3 = 3
    #   run of 4              = 1x4 = 4
    #   run of 5              = 1x5 = 5
    #   run of 3 w/ pair      = 2x3 = 6
    #   run of 4 w/ pair      = 2x4 = 8
    #   run of 3 w/ 3 of kind = 3x3 = 9
    #   run of 3 w/ 2 pairs   = 4x3 = 12
    runs: (hand, sorted) ->
      if !hand.length
        return 0

      # convert hand to and sort by order index
      if !sorted
        hand = _.map hand, (card) ->
          order.inArray card.value
        hand.sort()

      # add each card connected to the first to the run
      run = [hand.shift()]
      step = (card) ->
        run.push(card) if connectionIn run, card
          
      step card, i for card, i in hand

      # determine how much run is worth
      runSpan = _.uniq(run).length
      if runSpan < 3
        return 0 + @runs(hand, true)

      # count pairs and sets to determine multiplier
      multiplier = 1
      switch @pairs hand
        when 2 then multiplier = 2
        when 4 then multiplier = 4
        when 6 then multiplier = 3

      return runSpan * multiplier

    # return 2 points for each pair in a hand
    #   hand                            points 
    #   one pair                      = 1x2 = 2
    #   two pairs                     = 2x2 = 4
    #   three of a kind (three pairs) = 3x2 = 6
    #   full house (four pairs)       = 4x2 = 8
    #   four of a kind (six pairs)    = 6x2 = 12
    pairs: (hand) ->
      if !hand.length
        return 0

      points = 0

      # match against first card in hard
      match = hand.shift()
      pair = (card) -> points += 2 * (card.value == match.value)
      pair card for card in hand

      # search for more pairs
      return @pairs(hand) + points
