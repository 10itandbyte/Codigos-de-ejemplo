clear all;

resistencia = 5;


funTensionMedia = @(x) sqrt(2)*220*sin(x);
funCorrienteEficaz = @(y) (sqrt(2)*220/resistencia).^2*(sin(y)).^2;

corrienteEficaz =  integral(funCorrienteEficaz,0,pi);
corrienteEficaz = sqrt((1/(2*pi))*corrienteEficaz);

tensionMedia = integral(funTensionMedia,0,pi);
tensionMedia = (1/(2*pi)*tensionMedia);
tensionMediaDos = sqrt(2)*220/pi;
corrienteMedia = tensionMediaDos/resistencia;
corrienteMaxDiodo = sqrt(2)*220/resistencia;
tensionInversaDiodo = -sqrt(2)*220;

tensiones = table(tensionMedia,corrienteMedia,corrienteMaxDiodo,tensionInversaDiodo...
,corrienteEficaz)


t = (0:0.0001:1); f = 50;
grados = t*18000;

% DIODO

largoVecTiempo = length(t);
vRectificado = zeros(1,largoVecTiempo);
vInverso = zeros(1,largoVecTiempo);
i=1;
for tiempo=0:0.0001:1
    V = sqrt(2)*220*sind(2*180*tiempo*f);
    if(V < 0)
       vRectificado(i)=0;
       vInverso(i) = V;
    elseif (V>0)
       vRectificado(i)=V;
       vInverso(i) = 0;
    end
    i = i+1;
end

V = sqrt(2)*220*sind(2*180*t*f);
iRectificado = vRectificado./resistencia;


figure(1)
subplot(4,1,1)
plot(grados, V,'linewidth',2)
xlim([0 720])
xline(180,'linewidth',2); xline(180*2,'linewidth',2)
xline(180*3,'linewidth',2); xline(180*4,'linewidth',2)
title('\fontsize{15} Voltaje Fuente')

subplot(4,1,2)
plot(grados, vRectificado,'x r')
xlim([0 720])
xline(180,'linewidth',2); xline(180*2,'linewidth',2)
xline(180*3,'linewidth',2); xline(180*4,'linewidth',2)
title('\fontsize{15} Voltaje en la carga')

subplot(4,1,3)
plot(grados, iRectificado,'o k')
xlim([0 720])
xline(180,'linewidth',2); xline(180*2,'linewidth',2)
xline(180*3,'linewidth',2); xline(180*4,'linewidth',2)
title('\fontsize{15} Corriente en la carga')

subplot(4,1,4)
plot(grados, vInverso,'b','linewidth',2)
xlim([0 720])
xline(180,'linewidth',2); xline(180*2,'linewidth',2)
xline(180*3,'linewidth',2); xline(180*4,'linewidth',2)
title('\fontsize{15} Tensión inversa en el diodo')
