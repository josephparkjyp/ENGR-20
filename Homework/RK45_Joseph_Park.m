clear, clc, close all;

% RK45 Assignment
% Joseph Park
% Dec 6, 2024

% Step 1: Define the Function
function [t,x] = rk45(f, x0, t0, t_stop, dt, err_tol)
    % f: anonymous function representing the ODE (i = f(t,x))
    % x0: initial state
    % t0: initial time
    % t_stop: stopping time
    % dt: initial time step size
    % err_tol: error tolerance to control adaptive step-sizing
    
    % Step 2: Butcher Tableau Cofefficients
    load('rk45_coeffs.mat');

    % Step 3: Initialize Time and State Arrays
    t = [t0:dt:t_stop];
    x = [zeros(size(t))];
    x(1) = x0;


end

