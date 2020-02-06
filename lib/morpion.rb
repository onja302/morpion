class BoardCase
    #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
    attr_accessor :value,:case_number
    
    def initialize(case_number)
      @value = ""
      @case_number = case_number
    end
    
    def to_s
      #TO DO : doit renvoyer la valeur au format string
      self.value = @value 
    end
  
  end
  
  class Board
    include Enumerable
    #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
    attr_accessor :board
  
    def initialize
      #TO DO :
      #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
      @board =  [*0..8].map { |i|  BoardCase.new(i).case_number }
      #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    end
  
    def to_s
    #TO DO : afficher le plateau
  
      puts "#{@board[0..2].join(" | ")}"
      puts "--|---|--"
      puts "#{@board[3..5].join(" | ")}"
      puts "--|---|--"
      puts "#{@board[6..8].join(" | ")}"
  
    # print @board[0..2]
    # puts ""
    # print @board[3..5]
    # puts ""
    # print @board[6..8]
    end
  
    def play(symbol)
      #TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
  
      while true
      case_number = gets.chomp()
      if @board[case_number.to_i] == "X" || @board[case_number.to_i] == "O"
        puts "choose another cell, this one is already taken"
      elsif case_number.to_i > 8 || case_number.to_i < 0 || case_number != case_number.to_i.to_s
        puts "choose a cell within the board"
      else
      @board = @board.each_index.map { |e| e == case_number.to_i ? @board[e] = symbol : @board[e] }
      break
      end
    end
    end
  
    def victory?
      #TO DO : qui gagne ?
      if (@board[0] == @board[1] && @board[0] == @board[2]) || (@board[3] == @board[4] && @board[3] == @board[5]) || (@board[6] == @board[7] && @board[6] == @board[8] ) || (@board[0] == @board[3] && @board[0] == @board[6]) || (@board[1] == @board[4] && @board[1] == @board[7]) || (@board[2] == @board[5] && @board[2] == @board[8]) ||( @board[0] == @board[4] && @board[0] == @board[8]) || (@board[2] == @board[4] && @board[2] == @board[6])
        return true
      else
        return false
      end
    end
    
    def draw?
      if @board.all? { |e| e == "X" || e == "O" } 
          return true
      else 
        return false
      end
    end
  
  
  end
  
  class Player
    #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
    attr_accessor :name, :symbol
    attr_writer :game_state
    
    def initialize()
      #TO DO : doit régler son nom, sa valeur, son état de victoire
      puts "your pseudo?"
      @name = gets.chomp()
      puts "choose your symbol : 'X' or 'O' ?"
      @symbol = gets.chomp()
      @game_state = "game in progress"
    end
  
  end
  
  class Game
    def initialize
      #TO DO : créé 2 joueurs, créé un board
      @board = Board.new
      @player1 = Player.new
      @player2 = Player.new
    end
  
    def go
      # TO DO : lance la partie
      while @board.victory? == false && @board.draw? == false
        self.turn
      end
      puts "do you want to play again (y/n)"
      @answer = gets.chomp()
      if @answer == "y"
        Game.new.go
      end
    end
  
    
  
    def turn
      #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
      
      ObjectSpace.each_object(Player) do |obj|
      @board.to_s
      puts ""
        if @board.draw? == true
          puts "it s a draw"
          break
        end
      puts "It is #{obj.name}'s turn"
      puts "What will you play?"
      puts "choose a case"
      @board.play(obj.symbol)
        if @board.victory? == true
          @board.to_s
          puts ""
          puts "#{obj.name} won"
          break
        end
      end
    end
  end
  
  Game.new.g