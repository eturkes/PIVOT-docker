# pivot-docker - Community-developed Docker container for PIVOT transcriptomics
# Copyright (C) 2019-2020  Emir Turkes
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

library("devtools")

BiocManager::install("BiocUpgrade") 
BiocManager::install("GO.db")
BiocManager::install("HSMMSingleCell")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("DESeq2")
BiocManager::install("SingleCellExperiment")
BiocManager::install("scater")
BiocManager::install("monocle")
BiocManager::install("GenomeInfoDb")
BiocManager::install("GenomicAlignments")
BiocManager::install("rtracklayer")
install_github("qinzhu/PIVOT")
BiocManager::install("BiocGenerics") # You need the latest BiocGenerics >=0.23.3
