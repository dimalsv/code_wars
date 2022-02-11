#https://www.codewars.com/kata/5a3dd29055519e23ec000074

def check_exam(arr1,arr2)
  result = 0
    arr1.each_with_index do |answer, index|
      points = arr2[index].eql?(answer) ? 4 : (arr2[index].empty? ? 0 : -1  )
      result += points
    end
  result >= 0 ? result : 0
end

puts check_exam(["a", "a", "b", "b"], ["a", "c", "b", "d"])
