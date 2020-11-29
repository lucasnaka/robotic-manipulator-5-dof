clear
clc

load('ensaio_degrau_duplo_positivo_junta.mat')

w1 = 200;
Vm1 = 5;
Vm2 = 9;
deltaVm = Vm2-Vm1;
w2 = mean(velPlantaDecimate(length(velPlantaDecimate)*2/3:length(velPlantaDecimate)));

zinf = w2-w1;
K = zinf/deltaVm; % rad/s/V
phi = K*Vm1-w1;
% phi = 43.47;
% 0.63*zinf+w1
T = 0.01;

Kl = w1/Vm1;

xi = 1;
wn = 60;
Jeff = 0.5;
Beff = Jeff/T;
Kl_eff = Kl*Beff;
Kd = (2*xi*wn*Jeff - Beff)/Kl_eff;
N = 4;
Kp = wn^2*Jeff/K;
Td = Kd/Kp;

velBancada.time = t;
velBancada.signals.values = velPlantaDecimate;
velBancada.signals.dimensions = 1;

% Carrega a saida da simulacao e plota
load('output_naoLinear_junta1.mat')

time = out.tout;
velLinear = out.outputs.Data(:,2);
velNaoLinear = out.outputs.Data(:,1);
velBancadaOut = out.outputs.Data(:,3);

figure
hold on
plot(time,velBancadaOut,'Color',[0.4660, 0.6740, 0.1880],'Linewidth',0.6)
plot(time,velLinear,'Color',[0, 0.4470, 0.7410],'Linewidth',1.7)
plot(time,velNaoLinear,'Color',[0.8500, 0.3250, 0.0980],'Linewidth',1.7)
grid on
xlabel('Tempo (s)')
ylabel('Velocidade (rad/s)')
legend('Ensaio', 'Modelo linear', 'Modelo não-linear','Location','Southeast')


figure
hold on
plot(time(595:655),velBancadaOut(595:655),'Color',[0.4660, 0.6740, 0.1880],'Linewidth',1.2)
xlabel('Tempo (s)')
ylabel('Velocidade (rad/s)')
grid on