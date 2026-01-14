%T = readtable('datos_simulacion31.csv');  % Lee el CSV con encabezados
T = readtable('datos_simulacion.csv');  % Lee el CSV con encabezados

tiempo = T{:, 1};  % Primera columna (Tiempo)

%% Figura 1: Señales individuales de columnas B a G
figure;
hold on;
for i = 2:6  % Columnas B a G (2 a 7)
    plot(tiempo, T{:, i}, 'LineWidth', 1.5);
end
hold off;

grid on;
xlabel('Time [s]');
ylabel('P[W]');
title('Power');
legend(T.Properties.VariableNames(2:6), 'Interpreter', 'none');
print('Power_5.png', '-dpng', '-r300');



%% Figura 3: SOC BAT1
% Suma de columnas B a E (columnas 2 a 5)
soc_bat1 = T{:, 7};


figure;
hold on;
plot(tiempo, soc_bat1, 'b', 'LineWidth', 1.5);  % Línea azul

hold off;

grid on;
xlabel('Tiempo [s]');
ylabel('Soc %');
title('SOC BAT1');
legend('SOC');

