clc; clear;

% 1. Load files
golden_real = load('golden_tx_real.txt'); 
golden_imag = load('golden_tx_imag.txt');
rtl_real = load('rtl_tx_real.txt');       
rtl_imag = load('rtl_tx_imag.txt');

% Align lengths in case of mismatch
min_len = min(length(golden_real), length(rtl_real));
golden_real = golden_real(1:min_len);
golden_imag = golden_imag(1:min_len);
rtl_real = rtl_real(1:min_len);
rtl_imag = rtl_imag(1:min_len);

% ==============================================
% 2. Scaling & Exporting Exact Floating-Point
% ==============================================
scale_factor = 31; 

% Multiplication ONLY - No round() or floor()
golden_real_scaled_exact = golden_real * scale_factor;
golden_imag_scaled_exact = golden_imag * scale_factor;

% Exporting exact values with maximum double precision (up to 16 digits)
dlmwrite('golden_tx_real_scaled_exact.txt', golden_real_scaled_exact, 'precision', '%.16g');
dlmwrite('golden_tx_imag_scaled_exact.txt', golden_imag_scaled_exact, 'precision', '%.16g');
% ==============================================

% 3. Calculate absolute difference for each sample
diff_real = abs(golden_real_scaled_exact - rtl_real);
diff_imag = abs(golden_imag_scaled_exact - rtl_imag);

% 4. Calculate Mean Absolute Error (MAE)
avg_error_real = mean(diff_real);
avg_error_imag = mean(diff_imag);

% 5. Calculate Average Error Percentage relative to peak amplitude
peak_val_real = max(abs(golden_real_scaled_exact));
peak_val_imag = max(abs(golden_imag_scaled_exact));

% Prevent division by zero
if peak_val_real == 0, peak_val_real = 1; end 
if peak_val_imag == 0, peak_val_imag = 1; end

avg_err_percent_real = (avg_error_real / peak_val_real) * 100;
avg_err_percent_imag = (avg_error_imag / peak_val_imag) * 100;

% 6. Print Report
disp('==============================================');
disp('Error Analysis Report (Exact MATLAB vs RTL)');
disp('==============================================');
disp(['Average Error (Real)           = ' num2str(avg_error_real)]);
disp(['Average Error Percentage (Real)= ' num2str(avg_err_percent_real) ' %']);
disp('----------------------------------------------');
disp(['Average Error (Imag)           = ' num2str(avg_error_imag)]);
disp(['Average Error Percentage (Imag)= ' num2str(avg_err_percent_imag) ' %']);
disp('==============================================');

% ==============================================
% 7. Plotting 3 Random Zoomed Windows
% ==============================================
window_size = 200;
max_start_idx = min_len - window_size;

random_starts = randi([1, max_start_idx], 1, 3);

for i = 1:3
    start_idx = random_starts(i);
    end_idx = start_idx + window_size - 1;
    
    fig_name = ['Random Zoom ' num2str(i) ' (Samples ' num2str(start_idx) '-' num2str(end_idx) ')'];
    figure('Name', fig_name, 'NumberTitle', 'off');
    
    % --- Real Part ---
    subplot(2, 2, 1);
    plot(golden_real_scaled_exact, 'b', 'LineWidth', 2); hold on;
    plot(rtl_real, 'r--', 'LineWidth', 1.5);
    xlim([start_idx, end_idx]);
    title(['Real Part (Samples ' num2str(start_idx) '-' num2str(end_idx) ')']);
    legend('MATLAB', 'RTL');
    grid on;
    
    subplot(2, 2, 3);
    plot(diff_real, 'k', 'LineWidth', 1.5);
    xlim([start_idx, end_idx]);
    title('Real Part Error');
    xlabel('Samples'); ylabel('Magnitude');
    grid on;
    
    % --- Imag Part ---
    subplot(2, 2, 2);
    plot(golden_imag_scaled_exact, 'b', 'LineWidth', 2); hold on;
    plot(rtl_imag, 'r--', 'LineWidth', 1.5);
    xlim([start_idx, end_idx]);
    title(['Imag Part (Samples ' num2str(start_idx) '-' num2str(end_idx) ')']);
    legend('MATLAB', 'RTL');
    grid on;
    
    subplot(2, 2, 4);
    plot(diff_imag, 'k', 'LineWidth', 1.5);
    xlim([start_idx, end_idx]);
    title('Imag Part Error');
    xlabel('Samples'); ylabel('Magnitude');
    grid on;
end