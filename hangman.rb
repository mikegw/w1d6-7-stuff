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

class HumanPlayer

  attr_accessor :public_word, :player_type, :name, :confused_speak

  def initialize(player_type)
    @public_word = nil
    @player_type = player_type
    ask_for_name(player_type)
  end

  def ask_for_name(player_type)
    print "#{self.player_type}'s name:  "
    @name = gets.chomp
  end

  def take_a_guess
    print "#{self.name.capitalize}, take a guess: "
    guess = gets.chomp
  end

  def handle(guess)
    if guess.length > 1
      print "#{self.name.capitalize}, is #{guess} your word?(y/n): "
      gets.chomp.downcase == "y" ? public_word = guess : (return :wrong_word)
    end

    print "#{self.name.capitalize}, is #{guess} in your word? (y/n): "
    if gets.chomp.downcase == "y"
      print "where?: "
      positions = gets.chomp.downcase.split(" ")
      positions.each do |i|
        (self.public_word)[i.to_i] = guess
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
    @confused_speak = ["Sorry, that makes no sense to me, but then I'm just a computer...",
                       "What the... I don't...",
                       "You really don't understand this game do you?"
                       "I'm going to go to bed now.  Why don't you go read a rule book?"]
  end

  def ask_for_name
    print "Guessers name:  "
    @name = gets
    puts @name
  end

  def confused
    confused_speak.empty? ? :wrong_word : confused[0].shift
  end

  def handle(guess)
    if guess.length == public_word.length
      secret_word == guess ? public_word = guess : (return :wrong_word)
    end

    if guess.length.between(2,guess.length)
      return confused
    end

    if @secret_word.include?(guess)
      public_word.each_char.with_index.map do |l,i|
        guess == secret_word[i] ? l = guess : "_"
      end
    end

    else
      return :wrong_letter
    end

    :handled
  end

  def pick_word
    self.secret_word = self.dictionary.sample
    self.public_word = '_' * self.secret_word.length
  end
end
