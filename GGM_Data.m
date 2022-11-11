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
## @deftypefn {} {@var{retval} =} GGM_Data (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Omen <Omen@LAPTOP-PSMR0IUC>
## Created: 2022-11-11

function [lon_ggm, lat_ggm, height_anomaly_ggm, gravity_anomaly_ggm] = GGM_Data (array)
  i = 1;
  lon_ggm = [];
  lat_ggm = [];
  height_anomaly_ggm = [];
  gravity_anomaly_ggm = [];
  while i <= rows(array)
    fid = fopen (array(i,:), "r");
    ggm = textscan (fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f',10000, 'Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',56);
    fclose(fid);
    lon_gg = [ggm(2){:}]; % longitude in degrees
    lat_gg = [ggm(3){:}]; % latitude in degrees
    height_anomaly_gg = [ggm(6){:}]; % meters
    gravity_anomaly_gg = [ggm(11){:}]; % mGal
    lon_ggm = [lon_ggm, lon_gg'];
    lat_ggm = [lat_ggm, lat_gg'];
    height_anomaly_ggm = [height_anomaly_ggm, height_anomaly_gg'];
    gravity_anomaly_ggm = [gravity_anomaly_ggm, gravity_anomaly_gg'];
    i = i+1;
  endwhile
endfunction
