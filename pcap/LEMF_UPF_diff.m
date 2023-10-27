clc
clear
close all
dati = load('result.mat');
cartella = './img/';
cartella2= './pdf/';
% Differenze tra LEMF e UPF
%% Chiamata 15 secondi
N_packets = (1:length(dati.var.sec_15.LEMF_UPF_diff_mean)); % asse x
dati.var.sec_15.LEMF_UPF_diff_mean = dati.var.sec_15.LEMF_UPF_diff_mean * 1e6; % trasformo in μs
figure(1)
plot(N_packets, dati.var.sec_15.LEMF_UPF_diff_mean)
legend('LEMF - UPF Diff')
ylabel('Difference [μs]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10); 
xlim([0, N_packets(1, end)])
grid on
title('15-second call ')
% Salvataggio del grafico 
% nome_file = [cartella,'15s_LEMF_UPF Diff.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '15s_LEMF_UPF Diff.pdf'];
% saveas(gcf, nome_file,'pdf');

%% Chiamata 30 secondi
N_packets = (1:length(dati.var.sec_30.LEMF_UPF_diff_mean)); % asse x
dati.var.sec_30.LEMF_UPF_diff_mean = dati.var.sec_30.LEMF_UPF_diff_mean * 1e6; % trasformo in μs
figure(2)
plot(N_packets, dati.var.sec_30.LEMF_UPF_diff_mean)
legend('LEMF - UPF Diff')
ylabel('Difference [μs]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1, end)])
grid on
title('30-second call ')
% Salvataggio del grafico 
% nome_file = [cartella,'30s_LEMF_UPF Diff.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '30s_LEMF_UPF Diff.pdf'];
% saveas(gcf, nome_file,'pdf');

%% Chiamata 45 secondi
N_packets = (1:length(dati.var.sec_45.LEMF_UPF_diff_mean)); % asse x
dati.var.sec_45.LEMF_UPF_diff_mean = dati.var.sec_45.LEMF_UPF_diff_mean * 1e6; % trasformo in μs
figure(3)
plot(N_packets, dati.var.sec_45.LEMF_UPF_diff_mean)
legend('LEMF - UPF Diff')
ylabel('Difference [μs]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1, end)])
grid on
title('45-second call ')
% Salvataggio del grafico 
% nome_file = [cartella,'45s_LEMF_UPF Diff.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '45s_LEMF_UPF Diff.pdf'];
% saveas(gcf, nome_file,'pdf');

%% Chiamata 60 secondi
N_packets = (1:length(dati.var.sec_60.LEMF_UPF_diff_mean)); % asse x
dati.var.sec_60.LEMF_UPF_diff_mean = dati.var.sec_60.LEMF_UPF_diff_mean * 1e6; % trasformo in μs
figure(4)
plot(N_packets, dati.var.sec_60.LEMF_UPF_diff_mean)
legend('LEMF - UPF Diff')
ylabel('Difference [μs]','FontSize',11);
xlabel('Packet [#]','FontSize',11);
set(gca, 'FontSize', 10);
xlim([0, N_packets(1, end)])
grid on
title('60-second call ')
% Salvataggio del grafico 
% nome_file = [cartella,'60s_LEMF_UPF Diff.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2, '60s_LEMF_UPF Diff.pdf'];
% saveas(gcf, nome_file,'pdf');