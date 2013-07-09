define ['jQuery', 'cribbage', 'card'], ($, Cribbage, Card) ->
  console.log 'wooo'
  console.log(Cribbage)
  window.Cribbage = Cribbage
  cribbage = new Cribbage()
  deck = cribbage.deck
  card = deck.draw()
  console.log(cribbage, deck, card)
  console.log new Card()
