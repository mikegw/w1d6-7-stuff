class Wordchainer
  def initialize(dictionary_file)
    @dictionary = File.readlines(dictionary_file).map(&:chomp)
  end

  def adjacent_words(word)
    dict = @dictionary.keep_if{|w| w.length == word.length }
    adj_words = []
    ('a'..'z').each do |l|
      (word.length-1).times do |i|
        next if l == word[i]
        new_word = word.dup
        new_word[i] = l
        adj_words << new_word if dict.include?(new_word)
      end
    end
    adj_words
  end
end

w = Wordchainer.new('dictionary.txt')
p w.adjacent_words('angle')