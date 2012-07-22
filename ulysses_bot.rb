class LitBot
  def eat_file(file_name)
    file = File.open(file_name)
    @source_text = file.read
    file.close
  end

  def speak_first_10_words
    puts
    print @source_text.split(' ').first(10).join(' ')
    puts
    puts '=' * 90 # This creates a bottom border under the text
    puts
  end

  def digest_file
    source_text_words = @source_text.split(' ')
    @word_pairs_and_probabilities = {}

    source_text_words.each_with_index do |word, index|
      hash_key = "#{word} #{source_text_words[index + 1]}"
      hash_value = source_text_words[index + 2]
      if @word_pairs_and_probabilities[hash_key]
        @word_pairs_and_probabilities[hash_key] << hash_value
      else
        @word_pairs_and_probabilities[hash_key] = [hash_value]
      end
    end
  end

  def speak
  	sentence = 0
  	fragment = @word_pairs_and_probabilities.first[0].split(' ')

  	while sentence < 35 do 
  		word_pair = fragment.last(2).join(' ')
  		next_word = @word_pairs_and_probabilities[word_pair].sample unless @word_pairs_and_probabilities[word_pair].nil?
  		fragment << next_word
  		
  		if next_word && (next_word.include?(".") || next_word.include?("?"))
  			sentence += 1
  		end
  	end 
  	
  	puts fragment.join(' ')

  end
end

bender = LitBot.new
bender.eat_file("huckle.txt")
bender.digest_file	
bender.speak

puts
puts "And now for something entirely different"
puts

ulysses_bot = LitBot.new
ulysses_bot.eat_file("ulysses.txt")
ulysses_bot.digest_file
ulysses_bot.speak

# BONUS HW
#hybrid_bot = ulysses_bot + bender
#hybrid_bot.speak


# # puts word_pairs_and_probabilities
# output_text = ['They', 'came']

# story = 0
# while story < 35 do
  # word_pair = output_text.last(2).join(' ')
  # next_word = word_pairs_and_probabilities[word_pair].sample unless word_pairs_and_probabilities[word_pair].nil?
  # output_text << next_word

  # if next_word && (next_word.include?(".") || next_word.include?("?"))
    # story += 1
  # end
# end
# puts output_text.join(' ')