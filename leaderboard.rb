# frozen_string_literal: true

# This class contains latest tally of players
class Leaderboard
  def create_tally(players, current_standing)
    data = players.sort_by { |p| [p.rank, -p.points] }
    previous_rank = current_standing - 1
    puts '######### Current Tally #########'
    data.each do |player|
      current_rank = if player.rank > players.count
                       previous_rank + 1
                     else
                       player.rank
                     end
      previous_rank = current_rank
      puts "Player: #{player.name} Point: #{player.points} Rank: #{current_rank}"
    end
  end

  def assign_rank(player, current_standing)
    player.rank = current_standing
    puts "#{player.name} won with rank: #{player.rank}"
    puts ''
  end
end
