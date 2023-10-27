clear;
close all;
% Elenco delle cartelle principali (15, 30, 45, 60)
mainDirectories = {'15s', '30s', '45s', '60s'};
% Inizializzo le variabili
UPF_duration = [];
UPF_duration_mean = [];
UPF_delta = []; 
POI_duration = [];
POI_duration_mean = [];
POI_delta = [];
LEMF_duration = [];
LEMF_duration_mean = [];
LEMF_delta = [];
LI_duration = [];
LI_duration_mean = [];
LEMF_UPF_diff = [];
%% Loop attraverso le cartelle principali
for k = 1:length(mainDirectories)
    parentDirectory = ['./' mainDirectories{k}];
    % Elenco delle sottocartelle (15sec (1), 15sec (2), ecc.)
    subfolders = dir(parentDirectory);
    subfolders = subfolders([subfolders.isdir]); % Filtra solo le cartelle
    % Loop attraverso le sottocartelle (15sec (1), 15sec (2), ecc.)
    for i = 3:length(subfolders) % Parti da 3 per evitare "." e ".."
        currentFolder = fullfile(parentDirectory, subfolders(i).name);
        disp(['Contenuto di ' subfolders(i).name ':']); %contenuto di 15sec (1)
        % Elenco dei file CSV nella cartella corrente
        csvFiles = dir(fullfile(currentFolder, '*.csv'));
        % Loop attraverso i file CSV nella cartella corrente
        for j = 1:length(csvFiles)
            currentFile = fullfile(currentFolder, csvFiles(j).name);
            data = readtable(currentFile);
            % in base al file viene filtrato per GTP (UPF), SRTP (POI,
            % LEMF) e non viene considerato l'MDF
            if strcmp(csvFiles(j).name, 'MDF.csv')
                continue;
            else
                data = data(data.Var6 == "SRTP", :);
            end
            % Estrapola il numero di sequenza dalla colonna Var8
            seq = regexp(data.Var8, 'Seq=(\d+)', 'tokens', 'once');
            data.SeqNumber = cellfun(@str2double, seq);  % Converte la cella in un array numerico
            % Elimina i duplicati basati solo sulla colonna SeqNumber
            [~, idx, ~] = unique(data.SeqNumber, 'stable');
            data = data(idx, :);
            % Calcolo durata chiamata
            duration = data.Var3(end) - data.Var3(1);
            % Calcolo dei tempi parziali 
            partial = [0; diff(data.Var3)];
            % Visualizza le prime 5 righe dei dati
            disp(['Contenuto di ' csvFiles(j).name ':']);
            disp(head(data));
            % A seconda del nome del file andare ad assegnare il valore di
            % durata e i parziali a ciascuna variabile
            if strcmp(csvFiles(j).name, 'UPF.csv')
                UPF_duration = [UPF_duration; duration];
                UPF_time = data.Var3; % tempi intercettazione
                % Con padarray vado a uniformare alla stessa lunghezza la
                % tabella UPF_delta che contiene i tempi parziali
                diffLength =  length(partial) - length(UPF_delta);
                if diffLength < 0
                    partial = padarray(partial,[abs(diffLength),0], NaN, 'post');
                elseif ~isempty(UPF_delta)
                    UPF_delta = padarray(UPF_delta, [diffLength, 0], NaN, 'post');
                end
                UPF_delta = [UPF_delta, partial];
            elseif strcmp(csvFiles(j).name, 'POI.csv')
                POI_duration = [POI_duration; duration];
                % Con padarray vado a uniformare alla stessa lunghezza la
                % tabella POI_delta che contiene i tempi parziali
                diffLength =  length(partial) - length(POI_delta);
                if diffLength < 0
                    partial = padarray(partial,[abs(diffLength),0], NaN, 'post');
                elseif ~isempty(POI_delta)
                    POI_delta = padarray(POI_delta, [diffLength, 0], NaN, 'post');
                end
                POI_delta = [POI_delta, partial];
            else
                LEMF_duration = [LEMF_duration; duration];
                LEMF_time = data.Var3; % tempi intercettazione
                % Con padarray vado a uniformare alla stessa lunghezza la
                % tabella LEMF_delta che contiene i tempi parziali
                diffLength =  length(partial) - length(LEMF_delta);
                if diffLength < 0
                    partial = padarray(partial,[abs(diffLength),0], NaN, 'post');
                elseif ~isempty(LEMF_delta)
                    LEMF_delta = padarray(LEMF_delta, [diffLength, 0], NaN, 'post');
                end
                LEMF_delta = [LEMF_delta, partial];
            end
        end
        % Terminati i file contenuti in una cartella (15s(1), 15s (2), ...)
        % è necessario calcolare la durata totale dell'intercettazione
        LI_duration = [LI_duration, LEMF_time(end) - UPF_time(1)];

        % Calcolo delle differenze di tempi tra LEMF e UPF
        difference = LEMF_time - UPF_time;
        % Con padarray vado a uniformare alla stessa lunghezza la
        % tabella LEMF_UPF_diff che contiene le differenze per ogni
        % simulazione
        diffLength =  length(difference) - length(LEMF_UPF_diff);
        if diffLength < 0
            difference = padarray(difference,[abs(diffLength),0], NaN, 'post');
        elseif ~isempty(LEMF_UPF_diff)
             LEMF_UPF_diff = padarray(LEMF_UPF_diff, [diffLength, 0], NaN, 'post');
        end
        LEMF_UPF_diff = [LEMF_UPF_diff, difference];
    end
    % Calcolo durata media per ciascuna simulazione (15s, 30s, 45s, 60s)
    UPF_duration_mean = [UPF_duration_mean, mean(UPF_duration)];
    UPF_delta_mean = nanmean(UPF_delta,2); % nanmean calcola la media ignorando i valori NaN
    POI_duration_mean = [POI_duration_mean, mean(POI_duration)];
    POI_delta_mean = nanmean(POI_delta,2);
    LEMF_duration_mean = [LEMF_duration_mean, mean(LEMF_duration)];
    LEMF_delta_mean = nanmean(LEMF_delta,2);
    LI_duration_mean = [LI_duration_mean, mean(LI_duration)];
    LEMF_UPF_diff_mean = nanmean(LEMF_UPF_diff,2);

    % Salvataggio ad ogni iterazione *_delta_mean, *_duration e LEMF_UPF_diff_mean
    type = str2double(regexp(mainDirectories{k}, '\d+', 'match'));
    field_name = ['sec_', num2str(type)];
    var.(field_name).UPF_delta_mean = UPF_delta_mean;
    var.(field_name).POI_delta_mean = POI_delta_mean;
    var.(field_name).LEMF_delta_mean = LEMF_delta_mean;
    var.(field_name).LEMF_UPF_diff_mean = LEMF_UPF_diff_mean;
    var.(field_name).LI_duration = LI_duration;

    % Svuotare le variabili prima di passare alla durata successiva
    UPF_duration = [];
    UPF_delta = [];
    POI_duration = [];
    POI_delta = [];
    LEMF_duration = [];
    LEMF_delta = [];
    LI_duration = [];
    LEMF_UPF_diff = [];
end
var.UPF_duration_mean = UPF_duration_mean;
var.POI_duration_mean = POI_duration_mean;
var.LEMF_duration_mean = LEMF_duration_mean;
var.LI_duration_mean = LI_duration_mean;
save('result', 'var');