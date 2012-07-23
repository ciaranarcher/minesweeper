module MineSweeper
  class MineField
    attr_accessor :rows, :cols, :field, :field_scored

    def initialize
      @field = []
      @field_scored = []
    end

    def valid?
      allowed_rng = 0..100

      # Check they were set
      return false if @rows.nil? || @cols.nil?

      # Check they are in range
      return false unless allowed_rng.include? @rows and allowed_rng.include? @cols

      true
    end

    def append_row(str)

      # Check all characters are * or . and there are only @rows of them
      return false unless str =~ /^[\*|\.]{#{@cols}}$/

      raise 'Too many rows!' if @field.length >= @rows

      @field << str

      true
    end

    def score_position(x, y)
      score = 0
      mine = '*'

      # If we have a mine in the position then return immediately
      return mine if @field[x][y] == mine


      unless (@field[x-1].nil?)
        score += 1 if @field[x-1][y-1] == mine and y-1 >= 0 and x-1 >= 0
        score += 1 if @field[x-1][y] == mine and x-1 >= 0
        score += 1 if @field[x-1][y+1] == mine and x-1 >= 0
      end

      score += 1 if @field[x][y-1] == mine and y-1 >= 0
      score += 1 if @field[x][y+1] == mine

      unless (@field[x+1].nil?)
        score += 1 if @field[x+1][y-1] == mine and y-1 >= 0
        score += 1 if @field[x+1][y] == mine
        score += 1 if @field[x+1][y+1] == mine
      end

      score
    end

    def score
      (0...@field.length).each do |x|
        @field_scored << []
        (0...@field[x].length).each do |y|
          @field_scored[x] << score_position(x, y)
        end
      end

      @field_scored
    end

    def print_field_scored
      s = ""
      
      @field_scored.each do |row|
        s += "#{row.join}\n"
      end

      s
    end
  end
end