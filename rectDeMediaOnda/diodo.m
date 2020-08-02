%% Diodo ideal
clear all;

% Comportamiento DIODO ideal.

corriente = 0:0.5:10;
tension = -10:0.5:0;
vector = zeros(1,length(corriente));

subplot(2,2,1)
plot(vector,corriente,'r','linewidth',5);
hold on
plot(tension,vector,'k','linewidth',5);
xlim([-5 5]); ylim([-1 5]); xlabel('\fontsize{15} Tensión Diodo') , ylabel('\fontsize{15} Corriente Diodo')
grid on; grid minor;
legend({'I_{d} - Polarización directa','V_{d} - Polarización inversa'})
title('\fontsize{15} Comportamiento diodo ideal')

% Comportamiento DIODO real
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iD: corriente por el diodo
% vD: voltaje diodo con ánodo positivo respecto al cátodo.
% iS: Corriente de fuga
% n: coeficiente de emisión valor entre 1 y 2. n depende del material
% y la construccion física del diodo.
% Para germanio n=1, para silicio n=2. En Diodos de silicios reales el
% valor de n varia entre 1.1 y 1.8
% vT: Voltaje térmico
% q: carga del electron
% T: Temperatura absoluta en kelvin.
% k: Constante de Boltzmann
% vTd: Voltaje umbral.
% vBr: Voltaje de ruptura.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vBr = 100;
n=1.3; 
q = 1.6022e-19; k = 1.3806e-23;
celcius=24; T = 273+celcius;
vT= k*T/q;
iS = 8e-9;
vD = -200:0.01:100;
funcion = (vD/n*vT);
iD = zeros(1,length(funcion));
for i = 1:1:length(funcion)
iD(i) = iS*(exp(funcion(i))-1); 
end
subplot(2,2,2)
plot(vD,iD)
% xlim([-0 2])
title('Diodo en polarización directa')
xlabel('tension'), ylabel('corriente')
grid on;

% Tension Zener
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vZ: Tension zener
% v: Tension inversa diodo
% iZm: Valor minimo de corriente inversa para que el diodo entre en la zona
% zener.
% a: Factor multiplicativo para incrementar la pendiente de la curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vZ = -150;
vR = 200;
n=1.3; 
q = 1.6022e-19; k = 1.3806e-23;
celcius=24; T = 273+celcius;
vT= k*T/q;
iS = 8e-9;

funcionZener = (vZ/n*vT);
iZm = iS*(exp(funcionZener)-1); 


funcionRuptura = (vR/n*vT);
a=iS*(exp(funcionRuptura)-1);

vD = -300:0.01:-200;

iZ = a*(vD-vZ).^3+iZm;
iZ = iZ*9.35^-7;
subplot(2,2,4)
plot(vD,iZ)
title('Diodo en polarización inversa')

I = [iZ iD]; 
vNorma = (-300:0.01:100+0.01);
subplot(2,2,3)
plot(vNorma,I,'b','linewidth',3);
title('\fontsize{15} Comportamiento diodo real')
xlabel('\fontsize{15} Tensión diodo'); ylabel('\fontsize{15} Corriente Diodo')
% ylim([-1 1])
grid on;

%% Componentes
% Fs = 48000;
% fSS = (0:1/Fs:1-1/Fs);
% 
% vFourier = fft(V,Fs);
% vRectFourier = fft(vRectificado,Fs);
% 
% plot(fSS,abs(vFourier))
% xlim([0 0.02])
% figure
% plot(fSS,abs(vFourier))
% xlim([0 0.02])


