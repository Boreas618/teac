import os
import decimal

os.chdir("/home/chalice/Public/sl/")
os.system("bash ./judge.sh")

ans = ['5.000000', '-1.000000', '12.000000', '2.000000', '18.000000', '8.000000', '3.750000', '7.000000', '9.000000', '3000000.000000', '13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096.000000', '512.000000']
cnt = 0
index = 0
with open("output.txt", "r") as f:
	for line in f:
		line = line.strip().replace(" ", "")
		
		if line == ">":
			break
		
		value = decimal.Decimal(line.split("=")[-1])
		if value == decimal.Decimal(ans[index]):
			cnt += 1
		index += 1

print("Correct: %d/12" % cnt)