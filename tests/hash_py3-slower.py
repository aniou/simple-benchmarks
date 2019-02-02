
import fileinput

domains = {}
for line in fileinput.input():
    if not line.startswith('valid-data:'): continue
    tokens = line.split()
    domain = tokens[1].strip('"')
    number = int(tokens[3])
    if domain in domains:
        domains[domain].append(number)
    else:
        domains[domain] = [number]

#print('ok')
print(len(domains), end=",")
