defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

    # List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  # La interrogación da un significado semántico al método,
  # diciendo que devolverá un valor booleano
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    # { hand: [], deck: []}
    # Pattern Matching  // Destructuring JS
    # {hand, rest_of_deck } = Enum.split(deck, hand_size)
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end

    # Con guión bajo, le decimos al compilador, que estamos cumpliendo Pattern Matching pero que nos da igual ese valor
    # el compilador no nos dará la advertencia de variable no usada
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)
    # es lo mismo que ... , esto se puede hacer teniendo
    # parámetros consistentes entre los métodos encadenados
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
