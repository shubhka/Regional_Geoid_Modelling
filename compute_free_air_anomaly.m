function [anomaly] = compute_free_air_anomaly(obs_grav, lat, elevation, ref_Ellipsoid)
  %calculates atmospheric correction for a given elevation
  %INPUT - 
  %1. obs_grav (double) - (mGal) Observed gravity of the data points
  %2. lat (double) - (degree) Latitudes of the data points
  %3. elevation (double) - (meters)  orthometric height of the data points
  %4. ref_ellipsoid(string) - reference ellipsoid either 'WGS84' or 'GRS80'
  %OUTPUT - 
  %   correction (double) - (mGal) correction to account for the gravitational attraction of the atmosphere

  free_air_dist = compute_free_air_correction(lat, elevation, ref_Ellipsoid);
  normal_grav = compute_normal_grav(lat, ref_Ellipsoid);
  anomaly = obs_grav + free_air_dist - normal_grav;
endfunction