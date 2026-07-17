x = load(".../earthquakes.txt") #Cambiar el path pertinentemente

#Magnitudes de los terremotos
c4=x(:,4)

#EJERCICIO 1

#Histograma
figure 1;
hist(c4, 1000)
xlabel("Magnitud")
ylabel("Frecuencia")

#Histograma con polígono de frecuencias
figure 2;
[a b] =hist(c4,1000)
[b;a]
hist(c4,1000)
hold on
plot([100 b 150],[0 a 0], '-or')
xlabel("Magnitud")
ylabel("Frecuencia")

#Gráfico valor vs. caso
figure 3;
plot(c4, 'o')
xlabel("Número de dato")
ylabel("Magnitud")

#Gráfico constante vs. valor
figure 4;
plot(c4, ones(size(c4)),'o')
xlabel("Magnitud")
ylabel("Constante")

#EJERCICIO 2

disp("Media="), disp(mean(c4))
disp("Desvío estandar="), disp(std(c4))
disp("Primer cuartil="), disp(quantile(c4,0.25))
disp("Tercer cuartil="), disp(quantile(c4,0.75))
disp("Coeficiente de asimetría="), disp(skewness(c4))
disp("Coeficiente de kurtosis="), disp(kurtosis(c4)-3)

#EJERCICIO 3

figure 5;
boxplot(c4)
xlabel("Terremotos")
ylabel("Magnitud")
