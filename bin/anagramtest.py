import string
word = input("Input the original word: ")
anagram = input("Input the anagram: ")
measurement = {}
measurement2 = {}
for i in range(0, 26):
    measurement[i] = word.count(string.ascii_lowercase[i])
    measurement2[i] = anagram.count(string.ascii_lowercase[i])

print(measurement == measurement2)
