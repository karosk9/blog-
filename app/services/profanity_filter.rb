class ProfanityFilter
    #tworzymy serwis który bdzie filtrował brzytkie słowa na stronie

  def initialize(text)
    @text = text
  end

  def censored_text
    censored_words.join(' ')
  end

  private

  PROFANITY_WORDS = %w(debil głupek)

  def text_words
    @text.split(' ')
  end

  def censored_words
    text_words.map do |word|
      if PROFANITY_WORDS.include? word
        word[0] = '*'
        word[-1] = '*'
      end
      word
    end
  end
end