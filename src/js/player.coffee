define ->
  class Player
    constructor: ->
      @score = 0
      @lastScore = 0
      @hand = []
      @crib = []

    score: ->
      return @score

    peg: (points) ->
      @lastScore = @score
      @score += points
