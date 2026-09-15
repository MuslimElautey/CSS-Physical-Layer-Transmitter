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
% 2. Scaling (Exact Floating-Point)
% ==============================================
scale_factor = 31; 

% exactValue (Floating-point scaled)
exact_real = golden_real * scale_factor;
exact_imag = golden_imag * scale_factor;

% fixedValue (RTL output)
fixed_real = rtl_real;
fixed_imag = rtl_imag;

% ==============================================
% 3. Calculate MSE according to Project Specs
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
disp('==============================================');
disp('OFFICIAL MSE VERIFICATION REPORT');
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