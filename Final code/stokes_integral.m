## Copyright (C) 2022 Omen
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} stokes_integral (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Omen <Omen@LAPTOP-PSMR0IUC>
## Created: 2022-11-10

function [retval,K] = stokes_integral (lon, lat, g_faye, ref_ellipsoid, res)
  lat_c = (max(max(lat)) + min(min(lat)))/2;
  lon_c = (max(max(lon)) + min(min(lon)))/2;

  x = (lon - lon_c).*cosd(lat);
  y = lat - lat_c;

  sin_2_shi = (sind(y/2).^2) + (sind(x/2).^2).*cosd(lat).*cos(lat_c);
  sin_2_shi(sin_2_shi < 0.00001) = 0.00001;
  sin_shi = real(sin_2_shi.^(1/2));
  shi = real(2.*asind(sin_shi));
  d = log(sin_shi + sin_2_shi);
  cos_shi = cosd(shi);
  K = (1./sin_shi) -4  - 6.*sin_shi - 5.*cos_shi - 3.*cos_shi.*log(d);
  K = (1./sin_shi) - 4 + 6*sin_shi + 10*sin_2_shi - (3 - 6*sin_2_shi) - d;
  %p = x.^2 + y.^2;
  %p(p < 0.000001) = 0.000001;
  %K = real(2./(p.^(1/2)));
  ellipsoid = choose_Ellipsoid(ref_ellipsoid);
  R = ellipsoid.a;
  F1 = fft2(K);
  F2 = fft2(g_faye);
  F3 = ifft2(F2.*F1);
  retval = real((R/4*pi).*F3.*((res*(pi/180))^2));
endfunction
