#https://www.codewars.com/kata/miles-per-gallon-to-kilometers-per-liter

def converter(mpg)
  coef = 4.54609188/1.609344
  (mpg/coef).round(2)

end

puts converter(5)