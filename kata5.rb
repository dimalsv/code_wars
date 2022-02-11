#https://www.codewars.com/kata/number-of-trailing-zeros-of-n

def zeros(n)
  zeros = 0
  while n>0
    n=n/5
    zeros += n
    end
  zeros
end

p zeros(25)

