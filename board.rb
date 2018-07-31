require_relative 'piece.rb'
require "colorize"
require_relative 'pieces/king.rb'
class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8, nil)}
  end

  def fill_colors
    8.times do |i|
      8.times do |j|
        if (i + j).even?
          grid[i][j] = :white
        else
          grid[i][j] = :black
        end
      end
    end
  end

  def render
    system("clear")
    puts "    0  1  2  3  4  5  6  7 "
    grid.each_with_index do |row, i|
      print " #{i} "
      row.each do |col|
        if col == :black
          print "   ".colorize(:background => :grey)
        elsif col == :white
          print "   ".colorize(:background => :white)
        elsif col == :yellow
          print "   ".colorize(:background => :yellow)
        elsif col.class.superclass == Piece
          print col
        end
      end
      puts
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    self.grid[row][col] = val
  end

  def move_piece(start_pos,end_pos)
    unless valid_pos?(start_pos) && valid_pos?(end_pos)
      raise "It is outside the board."
    end

    if self[start_pos] == nil
      raise "This is no piece at that position"
    end

    if self[start_pos].can_move?(end_pos)
      raise "That piece can not move there"
    end

    if @self[end_pos] != nil
      raise 'Can not kill a piece of the same color'
    end

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def valid_pos?(pos)
    pos.all? {|el| 0 <= el && 7 >= el}
  end
end

board = Board.new
board.fill_colors
p1 = King.new(:blue,[0,3], board, :grey)
# p2 = Piece.new("black", [2,2], board)
# board[[2,2]] = p2
board[[0,3]] = p1
board.render
