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





___|____"]

  attr_accessor :guesser, :word_chooser, :dictionary,
                :public_word, :wrong_guesses_left

  def initialize(guesser = nil, word_chooser = nil)
    @public_word = nil
    @guesser = guesser
    @word_chooser = word_chooser
    @dictionary
    @wrong_guesses_left = PICS.length - 1
    play
  end

  def play
    game_start_display
    ask_for_word
    loop do
      display_public_word
      guess = guesser.take_a_guess
      case word_chooser.handle(guess)
        when :wrong_word
          self.wrong_guesses_left = 0
        when :wrong_letter
          self.wrong_guesses_left -= 1
      end
      if game_over?
        game_end_display
        ask_new_game
        break
      end

    end
  end

  def game_start_display
    puts "\n\t\t\tHANGMAN!!
    #{PICS.reverse.map{|pic| pic.split("\n")}.transpose.map{|line_arr| line_arr.map{|line| '%-9.9s' % line}.join}.join("\n")}"
    puts "\n"
  end


  def ask_for_word
    self.public_word = self.word_chooser.pick_word
  end

  def display_public_word
    puts PICS[self.wrong_guesses_left]
    puts "Secret word is: " + self.public_word
  end

  def game_over?
    !self.word_chooser.public_word.include?("_") || wrong_guesses_left == 0
  end

  def game_end_display
    if public_word.include?("_")
      puts PICS.first
      puts "\nHard luck, #{self.guesser.name}, #{self.word_chooser.name} wins this time..."
    else
      puts "\nCongratulations, #{self.guesser.name}, you won!"
    end
  end


  def ask_new_game
    puts "\nWould you like to play again? (y/n)"
    play_again = gets.chomp.downcase
    Hangman.new(guesser, word_chooser) if play_again == "y"
  end



end