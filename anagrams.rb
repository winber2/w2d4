require 'benchmark'
require 'byebug'

def first_anagram?(word1, word2)
  perms = word1.chars.permutation(word1.length).to_a.map(&:join)
  perms.include?(word2)
end

p first_anagram?("gizmo", "sally")  == false
p first_anagram?("elvis", "lives")  == true

str = "sakjfhag"
str_shuffled = str.split('').shuffle.join

puts "First anagram (using array of permutations)"
puts "Str length = 5"
puts Benchmark.measure { first_anagram?("gizmo", "sally") }
puts Benchmark.measure { first_anagram?("elvis", "lives") }
puts "Str length = #{str.length}"
puts Benchmark.measure { first_anagram?(str, str_shuffled)}
puts "Str length = #{(str + "r").length}"
puts Benchmark.measure { first_anagram?(str + "r", "r" + str_shuffled)}

def second_anagram?(word, word2)
  w2_copy= word2.chars
  w_copy = word.chars
  word.chars.each_with_index do |char, i|
    dels = false
    word2.chars.each_with_index do |ch, idx|
      next if dels
      if char == ch
        dels = true
        w2_copy[idx] = 1
        w_copy[i] = 1
      end
    end
  end
  w2_copy.all?{|el| el == 1}
end

str = "sakjfhakjflkqwjdeolKWJSKqjwkjwhidjdadlaijdwiow"
long_string = "lkfjlakjflkajsfldjalkjf"*100000

puts "Second anagram"
# p second_anagram?("gizmo", "sally")
# p second_anagram?("elvis", "lives")
# p second_anagram?("ababa", "bbaba")

puts Benchmark.measure { second_anagram?("gizmo", "sally") }
puts Benchmark.measure { second_anagram?("elvis", "lives") }
puts Benchmark.measure { second_anagram?(str, str.split('').shuffle.join) }
puts Benchmark.measure { second_anagram?(str, str.split('').shuffle.join) }
# puts Benchmark.measure { second_anagram?(long_string, long_string.split('').shuffle.join) }

def third_anagram?(word, word2)
  word.chars.sort == word2.chars.sort
end

puts "Third anagram"
puts Benchmark.measure { third_anagram?("gizmo", "sally") }
puts Benchmark.measure { third_anagram?("elvis", "lives") }
puts Benchmark.measure { third_anagram?(str, str.split('').shuffle.join) }
puts Benchmark.measure { third_anagram?(long_string, long_string.split('').shuffle.join) }

def fourth_anagram?(word, word2)
  hash = Hash.new(0)
  word.chars.each {|el| hash[el] += 1}
  word2.chars.each {|el| hash[el] -= 1}
  hash.values.all? {|v| v == 0}
end

puts "Hashes"
puts Benchmark.measure { fourth_anagram?("gizmo", "sally") }
puts Benchmark.measure { fourth_anagram?("elvis", "lives") }
puts Benchmark.measure { fourth_anagram?(str, str.split('').shuffle.join) }
puts Benchmark.measure { fourth_anagram?(long_string, long_string.split('').shuffle.join) }
