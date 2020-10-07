# frozen_string_literal: true

require './player'
require './dice'
require './leaderboard'

# This class simulates game of dice
class GameOfDice
  attr_reader :players, :winning_points, :dice, :current_standing, :leaderboard

  def initialize(total_players = 0, winning_points = 0)
    @players = Array.new(total_players.to_i) { |i| Player.new(i + 1) }
    @winning_points = winning_points.to_i
    @dice = Dice.new
    @current_standing = 1
    @leaderboard = Leaderboard.new
  end

  def simulate
    start_game unless registered_players?
  end

  private

  def no_existing_players?
    players.empty?
  end

  def registered_players?
    registered_players = no_existing_players?
    puts('No player is registered') || registered_players if registered_players
  end

  def start_game
    shuffle
    players.cycle do |player|
      total_players = players.count
      break if current_standing > total_players
      next if won?(player)

      init_turn(player)
      puts ''
      assign_rank(player) if won?(player) && player.rank > total_players
      result_and_score
    end
  end

  def assign_rank(player)
    leaderboard.assign_rank(player, current_standing)
    @current_standing += 1
  end

  def result_and_score
    leaderboard.create_tally(players, current_standing)
    puts '----------------------------------'
    puts ''
  end

  def init_turn(player)
    puts "#{player.name} its your turn (press ‘r’ to roll the dice)"
    roll = gets.chomp
    if roll == 'r'
      points = turn_points(player)
      if points.zero?
        puts "#{player.name} turn skipped"
      else
        puts "#{player.name} got #{points} points"
      end
      player.points = player.points + points
    else
      puts 'Wrong input'
    end
  end

  def turn_points(player)
    points = skip_check_points(player)
    if points == 6
      puts "#{player.name} got another chance as he got a 6"
      next_roll = roll(player)
      player.previous_turn = next_roll
      points += next_roll
    elsif points == 1 && player.previous_turn == 1
      player.skip_turn = true
      puts "#{player.name} next turn skipped due to consecutive 1"
    end
    player.previous_turn = points
    points
  end

  def skip_check_points(player)
    points = if player.skip_turn
               0
             else
               roll(player)
             end
    player.skip_turn = false
    points
  end

  def roll(player)
    player.roll_dice(dice)
  end

  def won?(player)
    player.points >= winning_points
  end

  def shuffle
    players.shuffle!
  end
end
