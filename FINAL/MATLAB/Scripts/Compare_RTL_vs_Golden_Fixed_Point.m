clc; clear;

% Define the payload cases to process
payload_cases = {'0', '25', '127'};
rtl_suffixes  = {'0B', '25B', '127B'}; 

scale_factor = 31; 
window_size = 200;

for c = 1:length(payload_cases)
    current_case = payload_cases{c};
    rtl_suffix = rtl_suffixes{c};
    
    disp(' ');
    disp('==============================================');
    disp(['PROCESSING TEST CASE: ' current_case ' BYTES (FLOORED)']);
    disp('==============================================');
    
    % 1. Load files dynamically based on the current case
    golden_real = load(['golden_tx_real_' current_case '.txt']); 
    golden_imag = load(['golden_tx_imag_' current_case '.txt']);
    rtl_real    = load(['rtl_tx_real_' rtl_suffix '.txt']);       
    rtl_imag    = load(['rtl_tx_imag_' rtl_suffix '.txt']);
    
    % Align lengths in case of mismatch
    min_len = min(length(golden_real), length(rtl_real));
    if min_len == 0
        disp(['Error: Empty files detected for case ' current_case '. Skipping.']);
        continue;
    end
    
    golden_real = golden_real(1:min_len);
    golden_imag = golden_imag(1:min_len);
    rtl_real    = rtl_real(1:min_len);
    rtl_imag    = rtl_imag(1:min_len);
    
    % ==============================================
    % 2. Scaling & Floor
    % ==============================================
    golden_real_scaled = floor(golden_real * scale_factor);
    golden_imag_scaled = floor(golden_imag * scale_factor);
    
    % Exporting floored values 
    dlmwrite(['golden_tx_real_scaled_' current_case '.txt'], golden_real_scaled, 'precision', '%d');
    dlmwrite(['golden_tx_imag_scaled_' current_case '.txt'], golden_imag_scaled, 'precision', '%d');
    
    % ==============================================
    % 3. Calculate absolute difference for each sample
    diff_real = abs(golden_real_scaled - rtl_real);
    diff_imag = abs(golden_imag_scaled - rtl_imag);
    
    % 4. Calculate Mean Absolute Error (MAE)
    avg_error_real = mean(diff_real);
    avg_error_imag = mean(diff_imag);
    
    % 5. Calculate Average Error Percentage relative to peak amplitude
    peak_val_real = max(abs(golden_real_scaled));
    peak_val_imag = max(abs(golden_imag_scaled));
    
    % Prevent division by zero
    if peak_val_real == 0, peak_val_real = 1; end 
    if peak_val_imag == 0, peak_val_imag = 1; end
    
    avg_err_percent_real = (avg_error_real / peak_val_real) * 100;
    avg_err_percent_imag = (avg_error_imag / peak_val_imag) * 100;
    
    % 6. Print Report
    disp(['Average Error (Real)           = ' num2str(avg_error_real)]);
    disp(['Average Error Percentage (Real)= ' num2str(avg_err_percent_real) ' %']);
    disp('----------------------------------------------');
    disp(['Average Error (Imag)           = ' num2str(avg_error_imag)]);
    disp(['Average Error Percentage (Imag)= ' num2str(avg_err_percent_imag) ' %']);
    disp('==============================================');
    
    % ==============================================
    % 7. Plotting 3 Random Zoomed Windows
    % ==============================================
    % Ensure the window size does not exceed the array length
    current_window = min(window_size, min_len);
    max_start_idx = min_len - current_window;
    
    if max_start_idx > 0
        random_starts = randi([1, max_start_idx], 1, 3);
        for i = 1:3
            start_idx = random_starts(i);
            end_idx = start_idx + current_window - 1;
            
            fig_name = ['Case ' current_case 'B (Floored) - Zoom ' num2str(i) ' (Samples ' num2str(start_idx) '-' num2str(end_idx) ')'];
            figure('Name', fig_name, 'NumberTitle', 'off');
            
            % --- Real Part ---
            subplot(2, 2, 1);
            plot(golden_real_scaled, 'b', 'LineWidth', 2); hold on;
            plot(rtl_real, 'r--', 'LineWidth', 1.5);
            xlim([start_idx, end_idx]);
            title(['Real Part (' current_case ' Bytes)']);
            legend('MATLAB (Floored)', 'RTL');
            grid on;
            
            subplot(2, 2, 3);
            plot(diff_real, 'k', 'LineWidth', 1.5);
            xlim([start_idx, end_idx]);
            title('Real Part Error');
            xlabel('Samples'); ylabel('Magnitude');
            grid on;
            
            % --- Imag Part ---
            subplot(2, 2, 2);
            plot(golden_imag_scaled, 'b', 'LineWidth', 2); hold on;
            plot(rtl_imag, 'r--', 'LineWidth', 1.5);
            xlim([start_idx, end_idx]);
            title(['Imag Part (' current_case ' Bytes)']);
            legend('MATLAB (Floored)', 'RTL');
            grid on;
            
            subplot(2, 2, 4);
            plot(diff_imag, 'k', 'LineWidth', 1.5);
            xlim([start_idx, end_idx]);
            title('Imag Part Error');
            xlabel('Samples'); ylabel('Magnitude');
            grid on;
        end
    else
        disp(['Sequence too short to extract ' num2str(window_size) '-sample windows.']);
    end
end