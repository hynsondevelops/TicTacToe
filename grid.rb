class Grid
	def initialize
		@turn = 0;
		@grid = Array.new
		i = 0;
		for i in 0..2
			currentRow = Array.new
			for j in 0..2
				currentRow.push(' ')
			end
			@grid.push(currentRow)
		end
	end

	def checkTile(column, row)
		return @grid[row][column]
	end

	def updateTile(column, row, newValue)
		@grid[row][column] = newValue
	end

	def newTurn
		@turn += 1;
		printBoard
		if (@turn  == 10)
			puts "Tie Game!"
			return true;
		end
		playerTurn = @turn % 2
		if (playerTurn == 0)
			puts "Turn #{@turn}. Player 2 go!"
		else
			puts "Turn #{@turn}. Player 1 go!"
		end
		if (playerTurn == 0)
			winOrContinue = getPlay('O')
			if (winOrContinue) #win
				puts "Player 2 wins!"
				printBoard
			end
			return winOrContinue
		else
			winOrContinue = getPlay('X')
			if (winOrContinue) #win
				puts "Player 1 wins!"
				printBoard
			end
			return winOrContinue
		end
	end

	def getPlay(letter)
		playFound = false;
		while (!playFound)
			column = getColumn
			row = getRow
			if (checkTile(column, row) == ' ')
				updateTile(column, row, letter)
				return checkWin(column, row)
			end
		end

	end

	def getColumn
		column = -1
		while (!(column >= 0 && column <= 2))
			puts "Enter the column: "
			column = gets.to_i
		end
		return column
	end

	def getRow
		row = -1
		while (!(row >= 0 && row <= 2))
			puts "Enter the row: "
			row = gets.to_i
		end
		return row
	end

	def printBoard
		for i in 0..2
			print "#{@grid[i][0]} | #{@grid[i][1]} | #{@grid[i][2]}\n"
		end
	end

	def checkWin(column, row)
		return (checkHorizontal(row) || checkVertical(column) || checkDiagonal)
		#checkVertical(column)
		
	end

	def checkHorizontal(row)
		if (@grid[row][0] == @grid[row][1] && @grid[row][1] == @grid[row][2] && @grid[row][0] != ' ')
			return true;
		end
	end

	def checkVertical(column)
		if (@grid[0][column] == @grid[1][column] && @grid[1][column] == @grid[2][column] && @grid[0][column] != ' ')
			return true;
		end
	end

	def checkDiagonal
		if ((@grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[0][0] != ' ') || (@grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] && @grid[0][2] != ' '))
			return true;			
		end
	end

	def instructions
		puts "Welcome to Tic Tac Toe. Make a move by entering the row and column that you would like to select. (0,0) is top corner."
	end
end



gameOver = false;
ticTacToe = Grid.new
ticTacToe.instructions
while (!gameOver)
	gameOver = ticTacToe.newTurn
end