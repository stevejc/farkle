class GamesController < ApplicationController
  
  def new
    session[:player] = 0
    session[:winner] = 0
    session[:booked_points] = [0,0]
    session[:tentative_points] = 0
    session[:number_of_dice] = 6
    session[:scoring_dice] = []
  end
  
  def roll
    @score_this_roll = 0
     if session[:number_of_dice] == 0
       session[:number_of_dice] = 6
       session[:scoring_dice] = []
     end
      
    @score = 0
    @dice = []
    @remaining_dice = []
    @score_this_roll = 0
    
    session[:number_of_dice].times do
      @dice << rand(1..6)
    end
    @dice.sort!
    @dice.each do |d|
      @remaining_dice << d
    end
    count_score
  end
  
  def score
    session[:booked_points][session[:player]] += session[:tentative_points]
winner
    new_turn
  end
  
  def new_turn
    session[:tentative_points] = 0
    session[:number_of_dice] = 6
    session[:scoring_dice] = []
    change_player
  end
  
  def change_player
    if session[:player] == 0
      session[:player] = 1
    else
      session[:player] = 0
    end    
  end
  
  def count_score
    check_hand([1,2,3,4,5,6],6, 1000)
    check_hand([1,1,2,2,3,3],6, 750)
    check_hand([1,1,1,1,1,1],6, 500)
    check_hand([1,1,1,1,1],5, 500)
    check_hand([1,1,1,1],4, 400)
    check_hand([1,1,1],3, 300)
    check_hand([1,1],2, 200)
    check_hand([1],1, 100)
    check_hand([2,2,2,2,2,2],6, 800)
    check_hand([2,2,2,2,2],5, 600)
    check_hand([2,2,2,2],4, 400)
    check_hand([2,2,2],3, 200)
    check_hand([3,3,3,3,3,3],6, 1200)
    check_hand([3,3,3,3,3],5, 900)
    check_hand([3,3,3,3],4, 600)
    check_hand([3,3,3],3, 300)
    check_hand([4,4,4,4,4,4],6, 1600)
    check_hand([4,4,4,4,4],5, 1200)
    check_hand([4,4,4,4],4, 800)
    check_hand([4,4,4],3, 400)
    check_hand([5,5,5,5],4, 300)
    check_hand([5,5,5],3, 150)
    check_hand([5,5],2, 100)
    check_hand([5],1, 50)
    check_hand([6,6,6,6,6,6],6, 2400)
    check_hand([6,6,6,6,6],5, 1800)
    check_hand([6,6,6,6],4, 1200)
    check_hand([6,6,6],3, 600)
    if @score_this_roll == 0
      new_turn
    end
  end
  
  def check_hand(hand,number, points)
    if @remaining_dice.each_cons(number).include?(hand)
      session[:number_of_dice] -= number
      session[:tentative_points] += points
      @score_this_roll += points
      session[:scoring_dice] << hand
      hand.each do |x|
        @remaining_dice.delete_at(@remaining_dice.index(x))
      end
    end
  end
  
  def winner
    session[:winner] = 1 if session[:booked_points][session[:player]] >= 5000
  end
  
  def destroy
    raise "exit"
  end
    
end