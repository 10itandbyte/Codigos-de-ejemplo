%% Tensiones de fase
clear all


t = (0:0.0001:5); f = 50;
grados = t*18000;
tensionAn=sqrt(2)*220*sind(2*180*t*f);
tensionBn=sqrt(2)*220*sind(2*180*t*f+240);
tensionCn=sqrt(2)*220*sind(2*180*t*f+120);

tensionNb=sqrt(2)*220*sind(2*180*t*f+60);

% figure
% plot(grados,tensionBn,'r')
% hold on
% plot(grados,tensionNb,'k')
% xlim([0 720])



%% Calculo de tensiones de linea

tensionAb=tensionAn-tensionBn;
tensionaB=tensionAn+tensionNb;

figure 
subplot(2,1,1)
plot(grados,tensionAb);
hold on;
plot(grados, tensionAn);
plot(grados, tensionBn);
hold off
xlim([0 720])
title('Uso de tension BN')

subplot(2,1,2)

plot(grados,tensionaB);
hold on;
plot(grados, tensionAn);
plot(grados, tensionNb);
xlim([0 720])
title('Uso de tension NB')

%% Diagrama fasorial 

tension = sqrt(2)*220;
anguloAn=0; anguloBn = 240;

xyAn = cosd(anguloAn)+1i*sind(anguloAn);
xyBn = cosd(anguloBn)+1i*sind(anguloBn);

parteReal = real(xyAn) - real(xyBn);
parteImaginaria = imag(xyAn) - imag(xyBn);
numeroComplejo = parteReal + parteImaginaria;

angulo=atan2d(parteImaginaria,parteReal);
magnitud = abs(numeroComplejo);
magnitud = tension*magnitud;

figure
compass(tension*parteReal,tension*parteImaginaria,'r');
hold on;
compass(tension*cosd(anguloBn),tension*sind(anguloBn),'g');
compass(tension*cosd(anguloAn),tension*sind(anguloAn),'b');

%% Diagrama fasorial tensión NB

tension = sqrt(2)*220;
anguloAn=0; anguloBn = 60;

xyAn = cosd(anguloAn)+1i*sind(anguloAn);
xyBn = cosd(anguloBn)+1i*sind(anguloBn);

parteReal = real(xyAn) + real(xyBn);
parteImaginaria = imag(xyAn) + imag(xyBn);
numeroComplejo = parteReal + parteImaginaria;

angulo=atan2d(parteImaginaria,parteReal);
magnitud = abs(numeroComplejo);
magnitud = tension*magnitud;

figure
compass(tension*parteReal,tension*parteImaginaria,'r');
hold on;
compass(tension*cosd(anguloBn),tension*sind(anguloBn),'g');
compass(tension*cosd(anguloAn),tension*sind(anguloAn),'b');







