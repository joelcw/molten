import string,sys

data = sys.stdin.read()

datafixed1 = data.replace("file,rule,match,sentence\r\n","")

datafixed2 = datafixed1.replace("9U2",",")

sys.stdout.write(datafixed2)
