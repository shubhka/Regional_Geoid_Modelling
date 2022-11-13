function [anomaly] = compute_free_air_anomaly(obs_grav, lat, elevation, ref_Ellipsoid)
  free_air_dist = compute_free_air_correction(lat, elevation, ref_Ellipsoid);
  normal_grav = compute_normal_grav(lat, ref_Ellipsoid);
  anomaly = obs_grav + free_air_dist - normal_grav;
endfunction