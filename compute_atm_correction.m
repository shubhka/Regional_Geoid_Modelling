function [correction] = compute_atm_correction(elevation)
  %calculates atmospheric correction for a given elevation
  %INPUT - 
  %1. elevation (double) -(meter) Elevations for which atmopheric correction has to be computed  
  %OUTPUT - 
  %   correction (double) - (mGal) correction to account for the gravitational attraction of the atmosphere
  
  correction = 0.871 - (1.0298*1e-4.*elevation) - (2.1642*1e-13.*elevation.^3) - (2.2411*1e-22.*elevation.^5);
  correction += ((5.3105*1e-9.*elevation.^2) + (9.5246*1e-18.*elevation.^4));
endfunction