require 'board'
require 'pry'

describe Board do 

  let (:board) { Board.new }
  let (:game) { Game.new }

  describe "#initialize" do
    it 'initializes a board with 10 rows by default' do 
      expect(board.board.size).to eq(board.board_size)
    end

    it 'initializes a board with 10 columns by default' do 
      expect(board.board.transpose.size).to eq(board.board_size)
    end

    it 'initializes @flags to 9 by default' do 
      expect(board.flags).to eq(9)
    end
  end

  describe "#assign_flag_coordinates" do 
    before do 
      board.assign_flag_coordinates
    end
    it "randomly generates the number contained in @flags coordinates" do 
      expect(board.flag_coordinates.size).to eq(board.flags)
    end

    it "does not contain repeats" do 
      expect(board.flag_coordinates.uniq.size).to eq(board.flags)
    end
  end

  describe "#replace_repeat_flag_coordinates" do
    let(:board) { Board.new(10, 2) } 
    before do 
      board.flag_coordinates = [[2, 3], [2, 3]]
      board.replace_repeat_flag_coordinates
    end
    it "replaces duplicate flag coordinates" do 
      expect(board.flag_coordinates.uniq.size).to eq(board.flags)
    end
  end

  describe "#update_board" do 
    it "changes coordinate status based on Game.make_move" do 
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.flag_coordinates = [[3, 3], [1, 3]]
      board.update_board(game.make_move)
      binding.pry
      expect(board.board[1][2]).to eq(2)
    end
  end

  describe "#check_surrounding_squares" do
    let(:board) { Board.new(10, 2) }  
    it "returns number of bombs in adjacent squares in cleared square" do 
      board.flag_coordinates = [[3, 3], [1, 3]]
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.update_board(game.make_move)
      expect(board.check_surrounding_squares(game.make_move)).to eq(2)
    end
  end

end
