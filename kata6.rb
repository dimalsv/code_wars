#https://www.codewars.com/kata/ranking-nba-teams

def is_number? string  #метод для визначення чи дані в строці є числом
  true if Float(string) rescue false
end

def nba_cup(result_sheet, team)

  return "" if team.empty? #повертаємо пусту строку якщо не передана команда

  matches = result_sheet.split(',') #розбиваємо строку з іграми і записуємо в масив як окремі мачті
  table_with_results = {} #створюємо таблицю куди у вигляді хешу будемо записувати результати кожної команди
  default_row = {wins: 0, draws: 0, losses: 0, scored: 0, conceded: 0, points: 0} #створюємо початковий запис в таблицю, ключі - назви колонок

matches.each do |game| #починаємо проходити по масиву, де кожна ітреація це рядок з результатом однієї гри

    first_team_name = "" 
    second_team_name = "" 
    first_team_points = ""
    second_team_points = ""

    game_as_words_array = game.split(' ') #розбиваємо строки на окремі слова

    game_as_words_array.each do |word|
      if is_number?(word)                 #перевіряємо чи слово є число
        if first_team_points.empty?       #якщо це число і очки першої команди пусті, записуємо це в очки 1ої команди
          first_team_points = word
        else                              
          second_team_points = word       # в іншому випадку це очки 2ої команди
        end
      else                                #якщо не число, а слово
        if first_team_points.empty?       #і очки першої команди пусті, значить ми все ще проходимось по першій команді 
          if first_team_name.empty?       #якщо назва поки пуста
            first_team_name += word       #записуємо слово в назву першої команди
          else                            #якщо в назві вже щось записно
            first_team_name += " #{word}" #записуємо з пробілом
          end
        else                              #якщо очки 1ої команди записані, занчить ми проходимоь по другій команді
          if second_team_name.empty?        
            second_team_name += word      
          else                             
            second_team_name += " #{word}" 
          end
        end
      end
    end


    return "Error(float number):#{game}" if first_team_points.include?('.') || second_team_points.include?('.') #якщо очки одніє з команди float повертаємо помилку

    first_team_points = first_team_points.to_i    #конвертуємо строку в integer для можливості порівння
    second_team_points = second_team_points.to_i

    #якщо в таблиці нема ключа з назвою команди зиписуємо туди зклоновану строку по замовчуванню, в іншому випадку не переписуємо на пусту строку
    table_with_results[first_team_name] = default_row.dup if table_with_results[first_team_name].nil? 
    table_with_results[second_team_name] = default_row.dup if table_with_results[second_team_name].nil?


    #записуємо забиті та пропущені голи для кожної команди в кожні грі
    table_with_results[first_team_name][:scored]+= first_team_points
    table_with_results[first_team_name][:conceded]+= second_team_points
    table_with_results[second_team_name][:scored]+= second_team_points
    table_with_results[second_team_name][:conceded]+= first_team_points

    #порівнюємо забиті мячі команд і в залежності від результату додаємо перемоги/поразки/нічиї/заг к-ть очок
    if first_team_points>second_team_points
      table_with_results[first_team_name][:wins]+= 1
      table_with_results[first_team_name][:points]+= 3
      table_with_results[second_team_name][:losses]+= 1
    elsif first_team_points<second_team_points
      table_with_results[second_team_name][:wins]+= 1
      table_with_results[second_team_name][:points]+= 3
      table_with_results[first_team_name][:losses]+= 1
    else
      table_with_results[first_team_name][:draws]+= 1
      table_with_results[second_team_name][:draws]+= 1
      table_with_results[first_team_name][:points]+= 2
      table_with_results[second_team_name][:points]+= 2
    end
  end

  #строка з командою яку передали в аргументі та її показникам, або ж помилка якщо така команда не грала
  team_data=table_with_results[team]

  if team_data.nil?
    return "#{team}:This team didn't play!"
  else
    return "#{team}:W=#{team_data[:wins]};D=#{team_data[:draws]};L=#{team_data[:losses]};Scored=#{team_data[:scored]};Conceded=#{team_data[:conceded]};Points=#{team_data[:points]}"
  end

end


result_sheet = "Los Angeles Clippers 104 Dallas Mavericks 104, Los Angeles Clippers 25 Boston 2 "
wrong_input_string = "Los Angeles Clippers 104.9 Dallas Mavericks 88, Los Angeles Clippers 12 Boston 20"

puts nba_cup(result_sheet, "Los Angeles Clippers")
