%% Thermal Noise Simulation and Analysis
% Objective:
% Simulate and analyze thermal (Johnson-Nyquist) noise
% and visualize its time-domain behavior and PSD.

clear; close all; clc;

%% Parameters
k = 1.38e-23;      % Boltzmann constant (J/K)
B = 1e6;           % Bandwidth (Hz) = 1 MHz
R = 100;           % Resistance (Ohms)
T = 300;           % Temperature (Kelvin)
n_samples = 10000; % Number of samples

%% Time vector
time = (0:n_samples-1) / B;

%% Generate Thermal Noise
thermal_noise = sqrt(4 * k * T * R * B) * randn(1, n_samples);

%% Plot Time-Domain Noise
figure;
plot(time, thermal_noise);
xlabel('Time (seconds)');
ylabel('Voltage (V)');
title('Thermal Noise in Time Domain');
grid on;

%% Power Spectral Density (PSD) Analysis
[psd, freq] = pwelch(thermal_noise, [], [], [], B);

figure;
semilogx(freq, 10*log10(psd));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density of Thermal Noise');
grid on;

%% Display RMS Noise Voltage (Theoretical vs Simulated)
Vn_theoretical = sqrt(4 * k * T * R * B);
Vn_simulated = rms(thermal_noise);

fprintf('Theoretical RMS Noise Voltage: %.3e V\n', Vn_theoretical);
fprintf('Simulated RMS Noise Voltage:   %.3e V\n', Vn_simulated);
