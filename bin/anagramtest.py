import string, sys
if (len(sys.argv) == 1):
    word = input("Input the original word: ")
    anagram = input("Input the anagram: ")
elif (len(sys.argv) == 3):
    word = sys.argv[1]
    anagram = sys.argv[2]
measurement= {}
measurement2 = {}
for i in range(0, 26):
    measurement[i] = word.count(string.ascii_lowercase[i])
    measurement2[i] = anagram.count(string.ascii_lowercase[i])

print(measurement == measurement2)
