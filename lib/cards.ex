defmodule Cards do
  @moduledoc """
    Providers methods for creating and handling a deck of cards
  """

  @doc """
    Return a list of strings representing a deck of playing cards
  """
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

  @doc """
    Shuffle the deck.
    The argument `deck` is the list of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card
    Then `deck` argument is the list of cards and `card` is the card we want to find in the list.

    ## Examples

        iex> deck = Cards.create_deck
        ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
        "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
        "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
        "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
        "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
        iex> Cards.contains?(deck, "Ace of Spades")
        true

  """
  def contains?(deck, card) do
  # La interrogación da un significado semántico al método,
  # diciendo que devolverá un valor booleano
    Enum.member?(deck, card)
  end

  @doc """
    Divide a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.
    The argument `deck` is the list of cards.

    ## Examples

        iex> deck = Cards.create_deck
        iex> { hand, _deck } = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    # { hand: [], deck: []}
    # Pattern Matching  // Destructuring JS
    # {hand, rest_of_deck } = Enum.split(deck, hand_size)
    Enum.split(deck, hand_size)
  end

  @doc """
    Save file in filesystem.
    The argument `deck` is the list of cards.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Laod file from filesystem
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end

    # Con guión bajo, le decimos al compilador, que estamos cumpliendo Pattern Matching pero que nos da igual ese valor
    # el compilador no nos dará la advertencia de variable no usada
  end

  @doc """
    Create hand joinning create deck, shuffle and deal.
    Then `hand_size` argument indicates how many cards should
    be in the hand.
  """
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
