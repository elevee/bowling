class BowlingGame

  # Start the game with an empty tally of shots
  def initialize
    @rolls = []
    @frame = 1
  end

  
  # Record a roll in the game.
  #
  # pins - The Integer number of pins knocked down in this roll.
  #
  # Adds pin count to end of scorecard, Returns nothing.
  def roll(pins)
    @rolls.push(pins)
  end

  # When roll knocks down 10 pins, it is a strike.
  # Returns a boolean: true if it is a strike, false if it is not.
  def strike?
    @roll == 10
  end

  # When roll knocks down 10 pins in two successive rolls, it is a spare.
  # Returns a boolean: true if it is a strike, false if it is not.
  def spare?
    @roll + @next_roll == 10
  end
  
  def double_strike?
    @roll + @next_roll == 20
  end


  # The logic for scoring in the event of a strike being rolled.
  # 10 points initially for the value of the strike itself.
  # Add value of current frame's first roll 
  # Add value of next frame's first roll
  # Iterate the current roll number by two. (turns in a frame)
  def score_strike
    @total_score += 10 + @rolls[@current_roll + 1] + @rolls[@current_roll + 2]
    @current_roll += 1
    frame_counter
  end

  # The logic for scoring in the event of a spare.
  # 10 points initially for the value of the spare itself.
  # Add value of next frame's first roll to current frame.
  # Iterate the current roll number by two. (turns in a frame)
  def score_spare
    @total_score += 10 + @rolls[@current_roll + 2]
    @current_roll += 2 
    frame_counter
  end

  # The logic for scoring in the absence of a strike or spare
  # Add value of the first roll
  # Add value of the second roll
  # Iterate the current roll number by two. (turns in a frame)
  def score_regular
    @total_score += @roll + @next_roll
    @current_roll += 2
    frame_counter
  end

  def frame_counter
    @frame += 1
  end

  def score
    # Total score starts off at zero and increments cumulatively
    @total_score = 0
    # Current roll is the index. Starts off at zero and increments cumulatively
    @current_roll = 0

    #While the index is less than the total amount of rolls (one less to account for next roll)
    while (@current_roll < @rolls.size - 1) && @frame < 10
      @roll      = @rolls[@current_roll]
      @next_roll = @rolls[@current_roll + 1]

      if strike?
        score_strike

      elsif spare?
        score_spare

      else
        score_regular
      end
      
    end

    if @frame == 10
    

      # If it's a double strike, add 10 points for the first strike
      # 10 points for second strike
      # Iterate one index
      if double_strike?
        #First throw scoring
        @total_score += 10 
        #Second throw scoring
        @total_score += 10
        #Final throw scoring
        @total_score += @rolls[@current_roll + 2]
        @current_roll += 3

      elsif strike?
        @total_score += 10 + @rolls[@current_roll + 1] + @rolls[@current_roll + 1] + @rolls[@current_roll + 2]
        @current_roll += 3
      elsif spare?
        @total_score += 10 + @rolls[@current_roll + 1] + @rolls[@current_roll + 1]
        @current_roll += 3 #doesn't like this line

      else
        @total_score += @rolls[@current_roll] + @rolls[@current_roll + 1]
        @current_roll += 2
      end

    end

    return @total_score
  end

end
