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
      case word_chooser.handle(guess)
        wrong_guesses_left = 0 when :wrong_word
        wrong_guesses_left -= 1 when :wrong_letter
      end
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
    play_again = gets.chomp.downcase
    Hangman.new(guesser, word_chooser) if play_again == y
  end



end

class HumanPlayer

  def initialize(player_type)
    @public_word = nil
    ask_for_name
    @player_type
  end

  def ask_for_name
    print "#{self.player_type}'s name:  "
    @name = gets.chomp
  end

  def take_a_guess
    "{self.name.capitalize}, take a guess: #{gets.chomp}"
  end

  def handle(guess)
    if guess.length > 1
      print "{self.name.capitalize}, is #{guess} your word?(y/n): "
      gets.chomp.downcase == "y" ? public_word = guess : return :wrong_word
    end

    print "{self.name.capitalize}, is #{guess} in your word? (y/n): "
    if gets.chomp.downcase == "y"
      print "where?: "
      positions = gets.chomp.downcase.split(" ")

      positions.each do |i|
        self.public_word[i] = guess
      end

    else
      return :wrong_letter
    end

    :handled
  end

  def pick_word
    print "#{self.name.capitalize}, how long is your word?"
    self.public_word = "_" * gets.to_i
  end
end

class ComputerPlayer

  def initialize
    @secret_word = nil
    ask_for_name
  end

  def ask_for_name
    print "Guessers name:  "
    @name = gets
    puts @name
  end
  def take_a_guess
    puts ""
    gets
  end

  def handle(guess)
  end

  def pick_word

  end
end
