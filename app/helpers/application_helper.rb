module ApplicationHelper
  
  def display_played_dice(dice)
    display = ""
    dice.each do |roll|
      display << roll.join(",") + " | "
    end
    return display
  end
  
  def display_tentative_score(score)
    if score == 0
      "  Farkle!"
    else
      "  #{score} points."
    end
  end
  
  def add_dice(dice) 
    

    num = case dice
      when 1 
        "one"
      when 2
        "two"
      when 3 
        "three"
      
      when 4
        "four"
      when 5
        "five"
      else
        "six"
      end

  
 (content_tag :div, class: "die #{num}" do
        (content_tag :span, "", :class => 'dot')
      end)
      
  end
  
  def show_die(player, current_player)
    if player == current_player
      ""
    else
      "hide_it"
    end
  end
  
end

