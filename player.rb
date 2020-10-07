# frozen_string_literal: true

# This class contains details of players
class Player
  attr_accessor :name, :points, :rank, :previous_turn, :skip_turn

  FIXNUM_MAX = (2**(0.size * 8 - 2) - 1)

  def initialize(id)
    @name = "Player-#{id}"
    @points = 0
    @rank = FIXNUM_MAX
    @previous_turn = 0
    @skip_turn = false
  end

  def roll_dice(dice)
    dice.roll
  end
end
