% Cargar el audio
[y, Fs] = audioread(uigetfile({'*.wav'}, 'Abrir'));

% Aplicar la transformada de Fourier
YT = fft(y);


%%%%%%%%%%%%%%%%%%%%%Test Para Audio Violin %%%%%%%%%%%%%%%%%%%%%%%%
% Definir los parámetros del los filtros
frecuenciaCorte = 100; % Frecuencia de corte en Hz
frecuenciaCortePasaBajas = 5000; % Frecuencia de corte para el filtro pasa-bajas en Hz
frecuenciaCentralPasaBandas = 3000; % Frecuencia central para el filtro pasa-bandas en Hz
anchoBandaPasaBandas = 2000; % Ancho de banda para el filtro pasa-bandas en Hz

% Obtener el número de muestras de la señal
numMuestras = length(y);

% Calcular la frecuencia de muestreo
frecuenciaMuestreo = Fs;

% Calcular el vector de frecuencias correspondiente al espectro de frecuencia
frecuencias = (0:numMuestras-1)*(frecuenciaMuestreo/numMuestras);

% Crear un filtro pasa-altas en el dominio de la frecuencia
filtro = zeros(size(YT));
filtro(frecuencias > frecuenciaCorte) = 1;

% Aplicar el filtro
YT_filtrada = YT .* filtro;

% Calcular la transformada inversa de Fourier para obtener la señal filtrada en el dominio del tiempo
senalFiltrada = ifft(YT_filtrada);

% Generar el vector de tiempo t correctamente
t = (0:numMuestras-1) / Fs;

% Plotear la señal original y la señal filtrada
figure;
subplot(2, 1, 1);
plot(t, y);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original');

subplot(2, 1, 2);
plot(frecuencias, abs(YT_filtrada));
xlabel('Frecuencia');
ylabel('Amplitud');
title('Señal Filtrada');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Fin Filtro Pasa-altas%%%%%%%%%%%%%%%%%%%%%%%%%

%Aplicar Transformada de Fourierh
YT2 = fft(real(senalFiltrada));

filtroPasaBajas = zeros(size(YT2));
filtroPasaBajas(frecuencias < frecuenciaCortePasaBajas) = 1;

% Aplicar el filtro
YT_filtrada2 = YT2 .* filtroPasaBajas;

% Calcular la transformada inversa de Fourier para obtener la señal filtrada en el dominio del tiempo
senalFiltrada2 = ifft(YT_filtrada2);

figure;
subplot(2, 1, 1);
plot(t, y);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original');

subplot(2, 1, 2);
plot(frecuencias, abs(YT_filtrada2));
xlabel('Frecuencia');
ylabel('Amplitud');
title('Señal Filtrada');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Fin Filtro Pasa-bajas%%%%%%%%%%%%%%%%%%%%%%%%%

%Aplicar Transformada de Fourierh
YT3 = fft(real(senalFiltrada2));

filtroPasaBandas = zeros(size(YT3));
filtroPasaBandas(abs(frecuencias - frecuenciaCentralPasaBandas) < anchoBandaPasaBandas/2) = 1;

% Aplicar los filtros
YT_filtrada3 = YT3 .* filtroPasaBandas;

% Calcular la transformada inversa de Fourier para obtener la señal filtrada en el dominio del tiempo
senalFiltrada3 = ifft(YT_filtrada3);

figure;
subplot(2, 1, 1);
plot(t, y);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original');

subplot(2, 1, 2);
plot(frecuencias, abs(YT_filtrada3));
xlabel('Frecuencia');
ylabel('Amplitud');
title('Señal Filtrada');



