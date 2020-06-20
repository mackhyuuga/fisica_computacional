import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np

while True:    
    try:
        file = str(input(('enter the name of the file containing the graphic informations: '))) + '.txt'
        dados = open(file, 'r')
    except FileNotFoundError:
        print("File not found, try again ")
        continue
    else:
        print("file found")
        break

x1 = []
y1 = []
x2 = []
y2 = []
x3 = []
y3 = []
t = []

dados.seek(141, 0)

for line in dados:
    line = line.strip()
    X1, Y1, X2, Y2, X3, Y3, T = line.split()
    x1.append(float(X1))
    y1.append(float(Y1))
    x2.append(float(X2))
    y2.append(float(Y2))
    x3.append(float(X3))
    y3.append(float(Y3))
    t.append(float(T))
dados.close()


plt.plot(x1, y1)
plt.plot(x2, y2)
plt.plot(x3, y3)
plt.axis([-3, 3, -3, 3])
plt.xlabel('x axis')
plt.ylabel('y axis')

plt.grid()


plt.show()


