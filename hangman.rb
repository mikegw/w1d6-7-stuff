class Hangman

  PICS = ["
    __
   |  |
   | _O_
   |  |
   | / \\
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
   |
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





___|____"].reverse

  attr_reader :guesser, :word_chooser, :dictionary

  def initialize(guesser = nil, word_chooser = nil)
    @public_word = nil
    @guesser = guesser
    @word_chooser = word_chooser
    @dictionary
    @wrong_guesses_left = PICS.length - 1
    #play
  end

  def play
    game_start_display
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

  def game_start_display
    puts "\n\t\t\tHANGMAN!!
    #{PICS.map{|pic| pic.split("\n")}.transpose.map{|line_arr| line_arr.map{|line| '%-9.9s' % line}.join}.join("\n")}"
    #puts PICS.map{|pic| pic.split("\n")}
  end


  def ask_for_word
    self.public_word = self.word_chooser.pick_word
  end

  def display_public_word
    puts "Secret word is: " + self.public_word
  end

  def game_over?
    secret_word.include?("_") || wrong_guesses_left == 0
  end

  def game_end_display
    if secret_word.include?("_")
      puts "Congratulations, #{self.guesser.name}, you won!"
    else
      puts "Hard luck, #{self.guesser.name} wins this time..."
    end
  end


  def ask_new_game
    puts "Would you like to play again? (y/n)"
    play_again? = gets
    Hangman.new(guesser, word_chooser) if play_again == y
  end



end