function [Ni] = compute_indirect_undulation(H, res, gridX, gridY, ref_ellipsoid)


  % Adjusting grid to padded matrix
  %gridx = X(1,:);  % longitude grid spacing
  %gridy = Y(:,1);  % latitude grid spacing

  %lat_range = max(gridy)- min(gridy);
  %long_range = max(gridx) - min(gridx);
  %lat1 = [(gridy-lat_range),gridy(1:end),(gridy+lat_range)];
  %long1 = [(gridx-long_range),gridx(1:end),(gridx+long_range)];

  %[gridX,gridY]=meshgrid(long1(:),lat1(:));

  %res = 0.02;
  % Mlat=mean(mean(Latm));
  ellipsoid = choose_Ellipsoid(ref_ellipsoid);
  R = ellipsoid.a;
  G = astronomical_constants('G').value;
  rho = 2.67*1e3;
  gamma = compute_normal_grav(gridY, ref_ellipsoid).*1e-5;

  % Converting Grid in meters unit
  Longm=gridX*111319.9*cosd(mean(mean(gridY)));
  Latm=gridY*111319.9;
  Mlat=mean(mean(Latm));

  % Computing R
  r=(sqrt((Longm-mean(mean(Longm))).^2+(Latm-mean(mean(Latm))).^2));
  r_inv=1./r;
  r_inv(r<111319.9*res)=0; % Check !!

  clear Longm Latm

  % Computing all the Fourier tranformation terms
  FR3=fft2(fftshift(r_inv.^3));
  FR5=fft2(fftshift(r_inv.^5));
  FH3=fft2(H.^3);
  FH5=fft2(H.^5);
  F1=fft2(ones(size(FH3)));

  c = G*rho./gamma;
  delx = 111319.9*cosd(Mlat)*res;
  dely = 111319.9*res;
  term1 = c.*(H.^2)*pi;
  Fterm1 = (R^2/6).*(ifft2(FH3.*FR3) - (H.^3).*ifft2(F1.*FR3));
  Fterm2 = ((3*R^2)/40).*(ifft2(FH5.*FR5) - (H.^5).*ifft2(F1.*FR5));
  term2 = c.*(Fterm1 + Fterm2)*((res*(pi/180))^2);

  Ni = real(-1*(term1 + term2));
  %Ni = Ni(end/3+1:2*end/3,end/3+1:2*end/3);

endfunction
