%% mma_imt_absorbance.m
% Absorbance of a metamaterial absorber from CST-exported S-parameters
% using impedance matching theory (IMT).
%
% Input : Excel table with columns f_GHz, S11_Re, S11_Im, S21_Re, S21_Im
% Output: plot and A_IMT.xlsx (columns f_GHz, A_IMT)
%
% Method (paper Eqs. (4)-(5)):
%   Zn    = sqrt(((1+S11)^2 - S21^2) / ((1-S11)^2 - S21^2))      [1]
%   Z     = Z0*Zn,  Gamma = (Z - Z0)/(Z + Z0),  A = 1 - |Gamma|^2  [2]
%
% Note: for a metal-backed absorber S21 ~ 0, so Gamma ~ S11 and
% A_IMT ~ 1 - |S11|^2. This is a consistency check, not an independent solver.
%
% References:
%  [1] M. L. Hakim et al., Sci. Rep. 12, 479 (2022), doi:10.1038/s41598-021-04236-1
%  [2] W. Zhu, in Metamaterials and Metasurfaces, IntechOpen (2019), doi:10.5772/intechopen.78581
%
% License: MIT (see LICENSE)

clear; clc; close all;

%% User settings
inputFile  = 'Re_Im_S11_S21.xls';   % exported from CST (.xls also works on all platforms)
outputFile = 'A_IMT.xls';
Z0 = 377;                           % free-space impedance (ohm)

%% Load data
data = readtable(inputFile);

f_GHz = data.f_GHz;
S11 = data.S11_Re + 1j*data.S11_Im;
S21 = data.S21_Re + 1j*data.S21_Im;

%% Impedance matching theory (IMT)
Zn    = sqrt(((1 + S11).^2 - S21.^2) ./ ((1 - S11).^2 - S21.^2)); %doi:10.1038/s41598-021-04236-1
Z     = Z0 * Zn;
Gamma = (Z - Z0) ./ (Z + Z0);
A_IMT = 1 - abs(Gamma).^2;  %doi:10.5772/intechopen.78581

%% Export
writetable(table(f_GHz, A_IMT), outputFile);
fprintf('Results saved to %s\n', outputFile);
plot(f_GHz, A_IMT);
xlabel('Frequency (GHz)'); ylabel('Absorbance (Impedance Matching Theory)');