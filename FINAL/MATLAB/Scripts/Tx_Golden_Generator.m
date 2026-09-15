clc; clear;
addpath 'common'
addpath 'transmitter'
disp('1. Loading configurations...');
% Initialize global variables (same as in runMe)
global chirpIndex;
global samplingFreqMhz;
simulationParameters;
globalSettings();

disp('2. Generating base Chirp sequence...');
chirpSequence = chirpSequenceGenerator(chirpIndex, samplingFreqMhz);

disp('3. Generating random Payload (25 bytes)...');
% 25 bytes * 8 bits = 200 bits
incomingStream = randi([0, 1], 1, 200); 

disp('4. Running Transmitter and extracting files...');
% Call the function (which includes our file saving code)
TxchirpSequences = ChirpSpreadSpectrum_Tx(incomingStream, 0, chirpSequence);

disp('🎉 Operation completed successfully! Check the folder for the 3 files.');