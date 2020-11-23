require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end
  def score
    # The word can’t be built out of the original grid
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    url = 'https://wagon-dictionary.herokuapp.com/' + params[:word]
    input_raw = open(url).read
    input_json = JSON.parse(input_raw)
    if params[:token].include?(params[:word])
      if input_json['found']
        @output = 'Congratulations ' + input_json['word'] + ' is a valid English word!'
      else
        @output = 'Sorry but ' + input_json['word'] + ' does not seem to be a valid English word...'
      end
    else
      @output = 'Sorry but ' + params[:word] + ' can\'t be built out of ' + params[:token]
    end
  end
end
