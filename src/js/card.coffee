define ['jQuery', 'templates'], ($, templates) ->
  class Card
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    suits =  ['s', 'c', 'd', 'h']

    randomFrom = (arr) -> arr[Math.floor(Math.random() * arr.length)]
    randomValue = -> randomFrom values
    randomSuit = -> randomFrom suits
    randomFace = -> randomValue() + randomSuit()
    
    # usage: new Card() returns a random card, new Card(face) 
    #   returns a card with requested face. Returns false if
    #   incorrect face syntax is passed in.
    # face syntax:
    # (value)(suit)
    # ex: 9c = Nine of Clubs
    constructor: (@face) ->
      if @face == undefined
        @value = randomValue()
        @suit = randomSuit()
        @face = @value + @suit
      else if !(typeof @face == 'string' && @face.length > 1)
        return false
      else
        split = face.length - 2
        @value = face.substring(0, split)
        @suit = face.substr(split)

        if values.indexOf(@value) == -1 || suits.indexOf(@suit) == -1
          return false

    values: ->
      return values

    suits: ->
      return suits

    render: ->
      html = $(templates.card this)
