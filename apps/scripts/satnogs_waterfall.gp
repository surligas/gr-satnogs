#!/usr/bin/gnuplot
#
#  gr-satnogs: SatNOGS GNU Radio Out-Of-Tree Module
#
#  Copyright (C) 2017, Libre Space Foundation <http://librespacefoundation.org/>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>

# satnogs-waterfall.gp
# Plot a waterfall diagramm from the output of the satnogs_waterfall_sink block.
#
# Usage:
# gnuplot -e "inputfile='waterfall_sink.data'" -e "outfile='waterfall.png'" /usr/local/share/satnogs/scripts/satnogs_waterfall.gp

reset
if (!exists("height")) height=800
if (!exists("width")) width=800
if (!exists("outfile")) outfile='/tmp/waterfall.png'

set view map
set terminal pngcairo size width,height enhanced font 'Verdana,14'
set output outfile
set datafile separator ','

unset key
set style line 11 lc rgb '#808080' lt 1
set border 3 front ls 11
set style line 12 lc rgb '#888888' lt 0 lw 1
set grid front ls 12
set tics nomirror out scale 0.75

set xlabel 'Frequency (kHz)'
set ylabel 'Time'

set cbtics scale 0

# Spectravue palette and scale
set cbtics (-110, -105, -100, -95, -90, -85, -80, -75, -70, -65, -60, -55, -50, -55, -40)

# palette
set palette defined (0 '#000000', \
                     1 '#0000e7', \
                     2 '#0094ff', \
                     3 '#00ffb8', \
                     4 '#2eff00', \
                     5 '#ffff00', \
                     6 '#ff8800', \
                     7 '#ff0000', \
                     8 '#ff007c')
set ylabel 'Time (seconds)'
set cbrange [-100:-50]
set cblabel 'Power (dB)'


# Plot and scale the frequency axis to kHz for readability
plot inputfile matrix rowheaders columnheaders using ($1*1e-3):2:3 with image
