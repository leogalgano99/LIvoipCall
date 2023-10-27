clc
clear
close all
dati = load('result.mat');
cartella = './img/';
cartella2= './pdf/';

% Processing Times
%% Chiamata 15 secondi
N_packets = (1:length(dati.var.sec_15.UPF_delta_mean)); % asse x
figure(1)
plot(N_packets, dati.var.sec_15.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
hold on
plot(N_packets, dati.var.sec_15.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(N_packets, dati.var.sec_15.LEMF_delta_mean, 'Color',[0,0.45,0.74])
title('15-second call ');
legend('UPF acquisition', 'POI capturing', 'LEMF collecting')
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1,end)])
grid on

% Plot con zoom
axes('Position',[0.5 0.4 0.1 0.2]);
box on;
plot(dati.var.sec_15.UPF_delta_mean, 'Color',[0.85 0.33 0.10])
hold on
plot(dati.var.sec_15.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(dati.var.sec_15.LEMF_delta_mean, 'Color',[0,0.45,0.74])
xlim([297.923, 297.934])
%ylim([1e-20 1e0])
grid off
set(gca,'xtick',[],'ytick',[])
set(gca,'FontName','Times New Roman','FontSize',10)

% Salvataggio del grafico 
% nome_file = [cartella, '15s_delta.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '15s_delta.pdf'];
% saveas(gcf, nome_file,'pdf');

% Subplot
figure(2)
subplot(3,1,1);
plot(N_packets, dati.var.sec_15.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('UPF acquisition');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,2); 
plot(N_packets, dati.var.sec_15.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('POI capturing');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,3); 
plot(N_packets, dati.var.sec_15.LEMF_delta_mean, 'Color',[0,0.45,0.74])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('LEMF collecting');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

% Salvataggio del grafico 
% nome_file = [cartella, '15s_subplot.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '15s_subplot.pdf'];
% saveas(gcf, nome_file,'pdf');

%% Chiamata 30 secondi
N_packets = (1:length(dati.var.sec_30.UPF_delta_mean)); % asse x
figure(3)
plot(N_packets, dati.var.sec_30.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
hold on
plot(N_packets, dati.var.sec_30.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(N_packets, dati.var.sec_30.LEMF_delta_mean, 'Color',[0,0.45,0.74])
title('30-second call ');
legend('UPF acquisition', 'POI capturing', 'LEMF collecting')
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1,end)])
grid on

% Plot con zoom
axes('Position',[0.5 0.4 0.1 0.2]);
box on;
plot(dati.var.sec_30.UPF_delta_mean, 'Color',[0.85 0.33 0.10])
hold on
plot(dati.var.sec_30.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(dati.var.sec_30.LEMF_delta_mean, 'Color',[0,0.45,0.74])
xlim([316.82, 316.85])
%ylim([1e-20 1e0])
grid off
set(gca,'xtick',[],'ytick',[])
set(gca,'FontName','Times New Roman','FontSize',10)

% Salvataggio del grafico 
% nome_file = [cartella, '30s_delta.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '30s_delta.pdf'];
% saveas(gcf, nome_file,'pdf');

% Subplot
figure(4)
subplot(3,1,1);
plot(N_packets, dati.var.sec_30.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('UPF acquisition');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,2); 
plot(N_packets, dati.var.sec_30.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('POI capturing');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,3); 
plot(N_packets, dati.var.sec_30.LEMF_delta_mean, 'Color',[0,0.45,0.74])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('LEMF collecting');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

% Salvataggio del grafico 
% nome_file = [cartella, '30s_subplot.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '30s_subplot.pdf'];
% saveas(gcf, nome_file,'pdf');


%% Chiamata 45 secondi
N_packets = (1:length(dati.var.sec_45.UPF_delta_mean)); % asse x
figure(5)
plot(N_packets, dati.var.sec_45.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
hold on
plot(N_packets, dati.var.sec_45.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(N_packets, dati.var.sec_45.LEMF_delta_mean, 'Color',[0,0.45,0.74])
title('45-second call ');
legend('UPF acquisition', 'POI capturing', 'LEMF collecting')
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1,end)])
grid on

% Plot con zoom
axes('Position',[0.5 0.4 0.1 0.2]);
box on;
plot(dati.var.sec_45.UPF_delta_mean, 'Color',[0.85 0.33 0.10])
hold on
plot(dati.var.sec_45.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(dati.var.sec_45.LEMF_delta_mean, 'Color',[0,0.45,0.74])
xlim([350.0363, 350.0366])
%ylim([1e-20 1e0])
grid off
set(gca,'xtick',[],'ytick',[])
set(gca,'FontName','Times New Roman','FontSize',10)

% Salvataggio del grafico 
% nome_file = [cartella, '45s_delta.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '45s_delta.pdf'];
% saveas(gcf, nome_file,'pdf');

% Subplot
figure(6)
subplot(3,1,1);
plot(N_packets, dati.var.sec_45.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('UPF acquisition');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,2); 
plot(N_packets, dati.var.sec_45.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('POI capturing');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,3); 
plot(N_packets, dati.var.sec_45.LEMF_delta_mean, 'Color',[0,0.45,0.74])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('LEMF collecting');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

% Salvataggio del grafico 
% nome_file = [cartella, '45s_subplot.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '45s_subplot.pdf'];
% saveas(gcf, nome_file,'pdf');


%% Chiamata 60 secondi
N_packets = (1:length(dati.var.sec_60.UPF_delta_mean)); % asse x
figure(7)
plot(N_packets, dati.var.sec_60.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
hold on
plot(N_packets, dati.var.sec_60.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(N_packets, dati.var.sec_60.LEMF_delta_mean, 'Color',[0,0.45,0.74])
title('60-second call ');
legend('UPF acquisition', 'POI capturing', 'LEMF collecting')
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1,end)])
grid on

% Plot con zoom
axes('Position',[0.5 0.4 0.1 0.2]);
box on;
plot(dati.var.sec_60.UPF_delta_mean, 'Color',[0.85 0.33 0.10])
hold on
plot(dati.var.sec_60.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
plot(dati.var.sec_60.LEMF_delta_mean, 'Color',[0,0.45,0.74])
xlim([988.781, 988.7825])
%ylim([1e-20 1e0])
grid off
set(gca,'xtick',[],'ytick',[])
set(gca,'FontName','Times New Roman','FontSize',10)

% Salvataggio del grafico 
% nome_file = [cartella, '60s_delta.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '60s_delta.pdf'];
% saveas(gcf, nome_file,'pdf');

% Subplot
figure(8)
subplot(3,1,1);
plot(N_packets, dati.var.sec_60.UPF_delta_mean, 'Color',[ 0.85 0.33 0.10])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('UPF acquisition');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,2); 
plot(N_packets, dati.var.sec_60.POI_delta_mean,'--', 'Color',[0.93 0.69 0.12])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('POI capturing');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

subplot(3,1,3); 
plot(N_packets, dati.var.sec_60.LEMF_delta_mean, 'Color',[0,0.45,0.74])
ylabel('Latency [s]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
title('LEMF collecting');
xlim([0, N_packets(1,end)]);
set(gca, 'FontSize', 10);

% Salvataggio del grafico 
% nome_file = [cartella, '60s_subplot.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '60s_subplot.pdf'];
% saveas(gcf, nome_file,'pdf');

