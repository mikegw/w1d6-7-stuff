class Hangman

  PICS = ["
    __
   |  |
   | _O_
   |  |
   | / \
___|____","
    __
   |  |
   | _O_
   |  |
   |
___|____","
    __
   |  |
   | _O_
   |  |
   |
___|____","
    __
   |  |
   |  O
   |
   |
___|____","
    __
   |  |
   |
   |
   |
___|____","

   |
   |
   |
   |
___|____","





___|____"]

  attr_reader :guesser, :word_chooser, :dictionary

  def initialize(guesser, word_chooser)
    @public_word = nil
    @guesser = guesser
    @word_chooser = word_chooser
    @dictionary
  end

  def play
    game_start_disp
    ask_for_word
    loop do
      display_public_word
      guess = guesser.take_a_guess

      word_chooser.handle(guess)
      if game_over?
        ask_new_game
        break
      end

    end
  end

  def ask_for_word
    self.public_word = self.word_chooser.pick_word
  end

end