clear all;
tic



%% voltaje de la fuente
t = (0:0.0001:1); f = 50;
radianes = t*pi*100;

V = sqrt(2)*220;
vFuente = V*sin(2*pi*t*f);

%% Funcion de corriente en la carga
r = 2; l = 0.01; 
w = 2*pi*f;
x = w*l;
alpha = atan2(x,r);
tau = l/r;

iL = (V/sqrt(r^2+x^2))*(sin(w*t-alpha)-sin(-alpha)*exp(-t/tau));

t=0; vRectificada = zeros(1,length(radianes));
cont=0; iRectificada = zeros(1,length(radianes));
vDiodo = zeros(1,length(radianes));
i=1;
while(i < length(radianes))
    if(iL(i) < 0)
    beta = t*pi*100;
    largo = i;
    i=10002;
    end
    t = t+0.0001;
    i=i+1;
end

diferencia = 200-largo;
iCarga(1:largo-1) = iL(1:largo-1);
iCarga(largo:200) = zeros(1,diferencia+1);
iCarga = repmat(iCarga,1,45);
iCarga(9991:10001) = zeros(1,11);


t = 0;
for i = 1:1:length(radianes)
 
    if(iCarga(i) ~= 0)
        vRectificada(i) = V*sin(2*pi*f*t);
        iRectificada(i) = iL(i);
        vDiodo(i) = 0;
    elseif(iCarga(i) == 0)
        vRectificada(i) = 0;
        iRectificada(i) = 0;
        vDiodo(i) = V*sin(2*pi*f*t);
    end 
    t = t+0.0001;
    
end

figure(1)

betaString =  num2str(beta);

subplot(4,1,1)
plot(radianes,vFuente,'r','linewidth',3)
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3);
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
ylabel('Voltaje'); xlabel('wt')
title('Tensión Fuente')

subplot(4,1,2)
plot(radianes,iCarga,'k','linewidth',3);
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3);
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
bG = xline(beta,'--r',{'\fontsize{15} beta' betaString},'linewidth',4);
bG.LabelVerticalAlignment = 'middle';
title('Corriente i_{L}')

subplot(4,1,3)
plot(radianes,vRectificada,'r','linewidth',3);
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3)
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
bG = xline(beta,'--k',{'\fontsize{15} beta' betaString},'linewidth',4);
bG.LabelVerticalAlignment = 'middle';
title('Tensión rectificada')

subplot(4,1,4)
plot(radianes,vDiodo,'m','linewidth',3);
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3)
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
bG = xline(beta,'--k',{'\fontsize{15} beta' betaString},'linewidth',4);
bG.LabelVerticalAlignment = 'middle';
title('Tensión inversa diodo')

%% Curva beta vs phi

figure(2)
funcion = @(b,phi) sin(b-phi)+sin(phi)*exp(-b/tan(phi));
fimplicit(funcion,[pi,2*pi,0,pi/2],'m','LineWidth',4);
xlabel('\fontsize{15} \beta [\pi < \omega t < 2\pi]'); ylabel('\fontsize{15} \phi [0 < \omega t < \pi/2]')
title('Curva de relación entre angulo \phi y ángulo \beta')
% fimplicit('sin(b-phi)+sin(phi)*exp(-b/tan(phi))=0',[pi,2*pi,0,pi/2])

%% dos
figure(3)
plot(radianes,vRectificada,'r','linewidth',3);
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3)
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
bG = xline(beta,'--k',{'\fontsize{15} beta' betaString},'linewidth',4);
bG.LabelVerticalAlignment = 'middle';
title('Tensión rectificada')
hold on

plot(radianes,iCarga,'k','linewidth',3);
xlim([0 4*pi])
xline(pi,'b',{'\fontsize{25} \pi'},'linewidth',3); 
xline(2*pi,'b',{'\fontsize{25} 2\pi'},'linewidth',3);
xline(3*pi,'b','linewidth',3); xline(4*pi,'b','linewidth',3)
bG = xline(beta,'--r',{'\fontsize{15} beta' betaString},'linewidth',4);
bG.LabelVerticalAlignment = 'middle';
title('Corriente i_{L}')

rad = [radianes, fliplr(radianes)];
inBetween = [vRectificada, fliplr(iCarga)];
fill(rad, inBetween, 'g');






toc