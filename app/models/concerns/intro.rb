module Intro
  extend ActiveSupport::Concern
  included do
    puts "I am included" #wywoła się gdy pierwszy raz zostanie załądowana klasa
  end
  def hello
    'hello'
  end


end
