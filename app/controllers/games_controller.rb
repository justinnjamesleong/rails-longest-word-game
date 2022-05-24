require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.shuffle[0..9]
  end

  def score
    @aarray = ["The word cannot be built out of the original grid","The word is valid according to the grid and is an English word","The word is valid according to the grid, but is not a valid English word"]
    @warray = params[:word].upcase.split('')
    @larray = params[:letters].split('')
    @difference = @warray - @larray
    @response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    @json = JSON.parse(@response.read)
    @result = @json["found"]
    if @difference.empty? == false
      @aarray = @aarray[0]
    else
      if @result
        @aarray = @aarray[1]
      else
        @aarray = @aarray[2]
      end
    end
  end
end
