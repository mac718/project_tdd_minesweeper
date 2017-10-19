require 'board'

describe Board do 

  let (:board) { Board.new }

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
end
