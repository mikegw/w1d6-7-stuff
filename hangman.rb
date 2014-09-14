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

  attr_accessor :secret_word, :confused_speak, :name, :public_word, :dictionary

  def initialize(player_type)
    @confused_speak = ["Sorry, that makes no sense to me, but then I'm just a computer...",
                       "What the... I don't...",
                       "You really don't understand this game do you?",
                       "I'm going to go to bed now.  Why don't you go read a rule book?"]
    @player_type = player_type
    @name = "Robo"
    @secret_word = nil
    @public_word = nil
    self.build_dictionary
  end

  def confused
    confused_speak.empty? ? :wrong_word : confused[0].shift
  end

  def handle(guess)
    if guess.length == public_word.length
      secret_word == guess ? public_word = guess : (return :wrong_word)
    end

    if guess.length.between?(2,guess.length)
      return confused
    end

    if @secret_word.include?(guess)
      self.public_word.each_char.with_index.map do |l,i|
        guess == @secret_word[i] ? l = guess : "_"
      end
    else
      return :wrong_letter
    end

    :handled
  end

  def build_dictionary
    self.dictionary = File.readlines("dictionary.txt")
    puts self.dictionary
  end

  def pick_word
    self.secret_word = self.dictionary.sample
    self.public_word = '_' * self.secret_word.length
  end
end
