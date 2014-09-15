class Wordchainer

  attr_accessor :dictionary, :all_seen_words, :current_words

  def initialize(dictionary_file)
    @dictionary = File.readlines(dictionary_file).map(&:chomp)
    @all_seen_words = Hash.new()
    @current_words = []
  end

  def adjacent_words(word, dict = nil)
    adj_words = []
    dict = @dictionary.keep_if{|w| w.length == word.length } if dict.nil?
    ('a'..'z').each do |l|
      (word.length).times do |i|
        next if l == word[i]
        new_word = word.dup
        new_word[i] = l
        adj_words << new_word if dict.include?(new_word)
      end
    end

    adj_words
  end

  def run(source, target)
    dict = @dictionary.keep_if{|w| w.length == source.length }
    self.all_seen_words[source] = nil
    self.current_words << source
    until self.current_words.empty?
      new_current_words = []
      @current_words.each do|word|
        explore_current_words(word,dict,new_current_words,target)
      end
      #self.current_words.each {|w| puts "#{w} came from #{self.all_seen_words[w]}"}
      self.current_words = new_current_words
    end
    build_path(target)
    self.all_seen_words = []
  end

  def explore_current_words(word,dict,new_current_words,target)
    adjacent_words(word, dict).each do |new_word|
      next if self.all_seen_words.has_key?(new_word)
      new_current_words << new_word
      self.all_seen_words[new_word] = word
      build_path(target) if word == target
    end
  end

  def build_path(target)
    path = [target]
    until self.all_seen_words[target] == nil
      target = self.all_seen_words[target]
      path << target
    end
    p path.reverse
    exit
  end

end

w = Wordchainer.new('dictionary.txt')
#p w.adjacent_words('angle')

w.run('misty', 'bland')