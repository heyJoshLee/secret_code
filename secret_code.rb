# Secret Code Game
class SecretCode
  attr_accessor :guesses_left, :current_guess, :answer
  CORRECT_MARKER = '0'
  INCORRECT_MARKER = 'X'
  INITAL_GUESSES = 5

  def initialize
    play_game
  end

  def play_game
    loop do
      system 'clear'
      @guesses_left = INITAL_GUESSES
      generate_answer
      display_welcome_message

      loop do
        prompt_for_answer
        check_answer
        print_guess
        break if won? || @guesses_left <= 0
      end

      display_endgame_message

      play_again = ''
      loop do
        puts 'Would you like to play again? (y,n)'
        play_again = gets.chomp.downcase
        break if %w(y n).include?(play_again)
      end
      break if play_again == 'n'
    end
  end

  def display_welcome_message
    puts 'Welcome to the game.'
    puts "Correct guesses are marked with a #{CORRECT_MARKER}"
    puts "Incorrect guesses are marked with a #{INCORRECT_MARKER}"
  end

  def prompt_for_answer
    puts "#{@guesses_left} guesses left"
    print '>> '
    temp_guess = ''
    loop do
      puts 'What is your guess? Please enter a 5 digit whole number'
      temp_guess = gets.chomp
      break if temp_guess.to_i.to_s == temp_guess && temp_guess.size == 5
    end
    @current_guess = temp_guess.chars.map(&:to_i)
  end

  def generate_answer
    @answer = []
    5.times { |index| @answer[index] = rand(0..9) }
    @answer = [1, 2, 3, 4, 5]
  end

  def check_answer
    won?
    @guesses_left -= 1
  end

  def won?
    @current_guess == @answer
  end

  def compare_each_number(num)
    @current_guess[num] == @answer[num] ? CORRECT_MARKER : INCORRECT_MARKER
  end

  def print_guess
    puts "  #{compare_each_number(0)}   #{compare_each_number(1)}   #{compare_each_number(2)}   #{compare_each_number(3)}   #{compare_each_number(4)}"
    puts "| #{@current_guess[0]} | #{@current_guess[1]} | #{@current_guess[2]} | #{@current_guess[3]} | #{@current_guess[4]} |"
  end

  def display_endgame_message
    puts won? ? 'You won' : 'You lost'
  end
end

SecretCode.new
