import matplotlib.pyplot as plt
import numpy as np
from math import sqrt
from scipy.stats import norm

# Path donde está guardado el archivo fouriera1.txt (cambiar pertinentemente)
file_path = ".../fouriera1.txt"

fo = 1E6

# Estimación del parámetro alfa de la variable aleatoria Xn utilizando máxima verosimilitud
def normal_alpha_MLE(X,T):
    s1 = 0
    s2 = 0
    for i in range(len(X)):
        s1 += X[i]*np.cos(2*np.pi*fo*T[i])
        s2 += (np.cos(2*np.pi*fo*T[i]))**2
    return s1/s2

# Estimación del parámetro sigma de la variable aleatoria Wn utilizando máxima verosimilitud
def normal_sigma_MLE(X, T, alpha):
    s = 0
    for i in range(len(X)):
        s += (X[i]-alpha*np.cos(2*np.pi*fo*T[i]))**2
    return (sqrt(s/len(X)))

# Guardo los valores de Xn y tn del archivo fouriera1.txt
xn_values = []
tn_values = []

with open(file_path, 'r') as file:
    # Se descartan las primeras 1002 líneas
    for _ in range(1002):
        next(file)

    for line in file:
        values = line.split()
        tn = float(values[0])
        xn = float(values[1])

        xn_values.append(xn)
        tn_values.append(tn)

# Estimación de alfa y sigma
alpha = normal_alpha_MLE(xn_values, tn_values)
sigma = normal_sigma_MLE(xn_values, tn_values, alpha)

print("alpha:", alpha, "\nsigma:", sigma)

# Normalización de Xn a Zn
zn_values = []
for i in range(len(xn_values)):
    zn_values.append((xn_values[i]-alpha*np.cos(2*np.pi*fo*tn_values[i]))/sigma)

# Polígono de frecuencia relativa de Zn
bin_number = 14
y,edges,_ = plt.hist(zn_values, bin_number, color='white',
                    weights=np.ones_like(zn_values) / len(zn_values))
midpoints = 0.5*(edges[1:]+edges[:-1])

# Obtención del polígono de frecuencias a partir de la función de distribución acumulada de Zn
polygon = []
for i in range(len(edges)-1):
    polygon.append(norm.cdf(edges[i+1])-norm.cdf(edges[i]))

# Muestro los polígonos
plt.xlim((edges[0]+edges[1])/2, (edges[-1]+edges[-2])/2)
plt.plot(midpoints, y, color='b', label='Tabla de valores', marker='o')
plt.plot(midpoints, polygon, color='r', label='FDA', marker='o')
plt.ylabel('Frecuencia relativa')
plt.xlabel('Valor de Zn')
plt.legend(title='Polígono obtenido a partir de:')
plt.grid()
plt.show()

# Genero 1000 estimaciones de alpha y verifico cuántas son menores a cero
alpha = 0.1
num_errors = 0
num_iterations = 1000

for iteration in range(num_iterations):

    wn_values = np.random.normal(0, 1, 1000)

    for i in range(len(wn_values)):
        xn_values[i]=alpha*np.cos(2*np.pi*fo*tn_values[i])+wn_values[i]

    current_alpha = normal_alpha_MLE(xn_values,tn_values)

    if current_alpha < 0:
        num_errors += 1

error_probability = num_errors/num_iterations

print("p:", error_probability)

# Cálculo del intervalo de confianza
confidence_interval = norm.ppf(0.975)*sqrt((error_probability*(1-error_probability))/num_iterations)

upper_level = error_probability+confidence_interval
lower_level = error_probability-confidence_interval

print("IC:", confidence_interval,
        "\nLímite superior:", upper_level, "\nLímite inferior:", lower_level)
