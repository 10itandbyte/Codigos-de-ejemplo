clear all;
t = (0:0.0001:1); f = 50;
radianes = t*pi*100;
V = sqrt(2)*220;

%% Funcion de corriente en la carga
r = 10; l = 0.05; 
w = 2*pi*f;
x = w*l;
alpha = atan2(x,r);
tau = l/r;

iL = (V/sqrt(r^2+x^2))*(sin(w*t-alpha)-sin(-alpha)*exp(-t/tau));

iUno = (V/sqrt(r^2+x^2))*(sin(w*t-alpha));
iDos = (V/sqrt(r^2+x^2)*-sin(-alpha)*exp(-t/tau));
iTres = iUno+iDos;
cont=0; t = 0;

for i = 1:1:length(radianes)
   
    if(iL(i) < 0 && cont == 0)
    beta = t*pi*100;
    cont = cont+1;
    end
    
    t = t+0.0001;
end


plot(radianes,iUno,'linewidt',3);
hold on
plot(radianes,iDos,'linewidt',3);
plot(radianes,iL,'linewidt',3);
xlim([0 beta])
legend({'i_{1}','i_{2}','i_{L} = i_{1}+i_{2}'})
ylabel('Corriente'); xlabel('\omega t')


