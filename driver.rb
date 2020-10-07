# frozen_string_literal: true

require './game_of_dice'

begin
  puts 'Enter number of players'
  players = gets.chomp
  puts 'Enter points to win the game'
  winning_points = gets.chomp
  new_game = GameOfDice.new(players, winning_points)
  new_game.simulate
rescue StandardError => e
  puts "Exception caught: #{e.message}"
end
