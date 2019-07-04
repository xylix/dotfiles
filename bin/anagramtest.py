import string, sys
if (len(sys.argv) == 1):
    word = input("Input the original word: ")
    anagram = input("Input the anagram: ")
elif (len(sys.argv) == 3):
    word = sys.argv[1]
    anagram = sys.argv[2]
measurement= {}
measurement2 = {}
alphabetstring = string.ascii_lowercase
for i in range(0, 26):
    measurement[alphabetstring[i]] = word.count(alphabetstring[i])
    measurement2[alphabetstring[i]] = anagram.count(alphabetstring[i])

if (measurement == measurement2):
    print("Anagram works")
else:
    diff = {x: measurement[x] - measurement2[x] for x in measurement if x in
            measurement2}
    for i in diff:
        if (diff[i] != 0):
            print(i + " "+ str(diff[i]))
