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
## @deftypefn {} {@var{retval} =} visualizer (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Omen <Omen@LAPTOP-PSMR0IUC>
## Created: 2022-11-11

function retval = visualizer (lat, lon, val, min_lat, min_lon, title_fig)
  lons = linspace(min_lon, min_lon+ 1, 100);
  lats = linspace(min_lat, min_lat+ 1, 100);
  [xx, yy] = meshgrid(lons, lats);
  vals = griddata(lon, lat, val, xx, yy, 'v4');
  figure;
  mesh(xx, yy, vals);
  xlim([min(lons) max(lons)]);
  daspect ([1 1]);
  colorbar;
  xlabel('longitude');
  ylabel('latitude');
  title(title_fig);
  savefig(title_fig);
endfunction
