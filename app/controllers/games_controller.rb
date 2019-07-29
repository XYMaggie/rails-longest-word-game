require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('a'..'z').to_a.sample }
  end

  def score
    longest_words = params[:_longest_words]
    @letters = params[:letters]
    # @letters = Array.new(15) { ('a'..'z').to_a.sample }
    longest_words_string = params[:_longest_words].to_s
    words_array = longest_words_string.split(//)
    match = words_array.all?{|i| @letters.include?(i)}
    if match
      if english_word == true
        @answer = "you got it, your score is 5"
      else
        @answer = "it's not an English word, your score is 1"
      end
    else
      @answer = "you are stupid, your score is 0"
    end
  end

  def english_word
    longest_words = params[:_longest_words]
    url = "https://wagon-dictionary.herokuapp.com/#{longest_words}"
    words = open(url).read
    user = JSON.parse(words)
    if user["found"] == true
      true
    else
      false
    end
  end
end
