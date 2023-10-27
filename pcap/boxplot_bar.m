clc
clear
close all
dati = load('result.mat');
cartella = './img/';
cartella2= './pdf/';

%% Grafico a barre
duration = [dati.var.UPF_duration_mean; dati.var.POI_duration_mean; dati.var.LEMF_duration_mean; dati.var.LI_duration_mean];
% Crea un vettore di nomi per le serie
Categorie = categorical({'UPF\newlineacquisition', 'POI\newlinecapturing', 'LEMF\newlinecollecting', 'Total\newlineLI procedure'});
Categorie = reordercats(Categorie,{'UPF\newlineacquisition', 'POI\newlinecapturing', 'LEMF\newlinecollecting', 'Total\newlineLI procedure'});
% Crea l'istogramma
figure(1);
bar(Categorie, duration);
set(gca, 'FontSize', 10);
ylabel('Average Latency [s]');  % Etichetta dell'asse y
legend('15s', '30s', '45s','60s','NumColumns', 2, 'Position',[0.68 0.84 0.22 0.082])
grid on
% Salvataggio grafico in 2 formati
% nome_file = [cartella, 'bar.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2,'bar.pdf'];
% saveas(gcf, nome_file,'pdf');

% Grafico a barre della durata dell'intercettazione (sottraendo i tempi
% della chiamata a ciascun dato)
effective_duration = duration - [15, 30, 45, 60];
figure(2);
bar(Categorie, effective_duration);
set(gca, 'FontSize', 10);
% limito l'asse y tra il valore più piccolo e il valore più grande per
% vedere meglio le differenze
ylim([min(effective_duration(:))-0.01 max(effective_duration(:))+0.01])
ylabel('Average Latency [s]');  % Etichetta dell'asse y
legend('15s', '30s', '45s','60s','NumColumns', 2, 'Position',[0.68 0.84 0.22 0.082])
grid on
% Salvataggio grafico in 2 formati
% nome_file = [cartella, 'Duration_bar.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2,'Duration_bar.pdf'];
% saveas(gcf, nome_file,'pdf');

%% Boxplot
LI_duration = [dati.var.sec_15.LI_duration', dati.var.sec_30.LI_duration', dati.var.sec_45.LI_duration', dati.var.sec_60.LI_duration'];
Size =[15, 30, 45, 60];
figure(3);
media = mean(LI_duration); % Calcola la media dei dati per ciascuna categoria
boxplot(LI_duration, Size);
hold on
plot(media,':k', 'Marker','square', 'MarkerFaceColor','k')
hold off
legend('Average latency of the total LI procedure', 'Position',[0.14 0.874 0.48 0.045]);
grid on
ylabel('Latency [s]','FontSize',11);
xlabel('Call Duration [s]','FontSize',11);
set(gca, 'FontSize', 10);

%plot con zoom
axes('Position',[0.6 0.2 0.2 0.3]);
box on;
boxplot(dati.var.sec_45.LI_duration, 45)
grid off
set(gca,'FontName','Times New Roman','FontSize',9)
set(gca, 'YAxisLocation', 'right'); % Mostra i tick a destra
% Salvataggio grafico in 2 formati
% nome_file = [cartella, 'boxplot.png'];
% saveas(gcf, nome_file);
% nome_file = [cartella2,'boxplot.pdf'];
% saveas(gcf, nome_file,'pdf');