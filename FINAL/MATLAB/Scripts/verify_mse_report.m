clc; clear;

% Define the payload cases to process
payload_cases = {'0', '25', '127'};
rtl_suffixes  = {'0B', '25B', '127B'}; 

scale_factor = 31; 

for c = 1:length(payload_cases)
    current_case = payload_cases{c};
    rtl_suffix = rtl_suffixes{c};
    
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
    rtl_real = rtl_real(1:min_len);
    rtl_imag = rtl_imag(1:min_len);
    
    % ==============================================
    % 2. Scaling (Exact Floating-Point)
    % ==============================================
    % exactValue (Floating-point scaled)
    exact_real = golden_real * scale_factor;
    exact_imag = golden_imag * scale_factor;
    % fixedValue (RTL output)
    fixed_real = rtl_real;
    fixed_imag = rtl_imag;
    
    % ==============================================
    % 3. Calculate MSE 
    % Equation: MSE = sum(|exact - fixed|^2) / sum(|exact|^2)
    % ==============================================
    % Real part MSE
    numerator_real = sum(abs(exact_real - fixed_real).^2);
    denominator_real = sum(abs(exact_real).^2);
    mse_real = numerator_real / denominator_real;
    
    % Imaginary part MSE
    numerator_imag = sum(abs(exact_imag - fixed_imag).^2);
    denominator_imag = sum(abs(exact_imag).^2);
    mse_imag = numerator_imag / denominator_imag;
    
    % Complex MSE (Combined)
    exact_complex = exact_real + 1i * exact_imag;
    fixed_complex = fixed_real + 1i * fixed_imag;
    numerator_complex = sum(abs(exact_complex - fixed_complex).^2);
    denominator_complex = sum(abs(exact_complex).^2);
    mse_complex = numerator_complex / denominator_complex;
    
    % ==============================================
    % 4. Print Official Verification Report
    % ==============================================
    disp(' ');
    disp('==============================================');
    disp(['OFFICIAL MSE VERIFICATION REPORT: ' current_case ' BYTES']);
    disp('==============================================');
    disp(['MSE (Real)           = ' num2str(mse_real, '%.6f')]);
    disp(['MSE (Imaginary)      = ' num2str(mse_imag, '%.6f')]);
    disp(['MSE (Complex Total)  = ' num2str(mse_complex, '%.6f')]);
    disp('----------------------------------------------');
    disp('Target Threshold     = 0.005');
    if mse_complex < 0.005
        disp('STATUS: PASSED (MSE is below the threshold!)');
    else
        disp('STATUS: FAILED (MSE exceeds the threshold!)');
    end
    disp('==============================================');
end