WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Middle column
  [2,5,8], # Last column
  [0,4,8], # Diagonal
  [2,4,6] # Diagonal
] 

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    pos_0 = board[combo[0]]
    pos_1 = board[combo[1]]
    pos_2 = board[combo[2]]

    if (pos_0 == "X" && pos_1 == "X" && pos_2 == "X") || (pos_0 == "O" && pos_1 == "O" && pos_2 == "O")
      return combo
    end
  end
  nil
end

def full?(board)
  board.reject{|pos| pos == "X" || pos == "O"} == []
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  combo = won?(board)
  if combo == nil
    return nil
  end
  board[combo[0]]
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(board, index, current_player)
    board[index] = current_player
  end
  
  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end
  
def turn_count(board)
    counter = 0
    board.each do |el|
        if el == "X" || el == "O"
            counter += 1
        end
    end
    counter
end

def current_player(board)
    count = turn_count board
    count.even? ? "X" : "O"
end

def turn(board)
    is_valid = false
    until is_valid
        puts "Please enter 1-9:"
        index = input_to_index gets.strip
        is_valid = valid_move?(board, index)
    end
    move(board, index, current_player(board))
    display_board(board)
end 
  
  # Define your play method below
  def play(board)
    until over?(board) do
        turn board
    end
    player = winner board
    if player
        puts "Congratulations #{player}!"
    elsif draw? board 
        puts "Cat's Game!"
    end
  end