## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(octawave)

## ----interactive_examples, eval = FALSE---------------------------------------
# # Launch the floating 3D live landscape visualizer
# plot_octawave_timesnap_3d(zeitpunkt = 0)
# 
# # Open the interactive multi-drop 3D zone for overlapping wave simulations
# interactive_multi_3d()
# 
# # Render the floating 3D volume model of the octahedral core in space
# plot_octawave_3d(resolution = 35, range = 5)

## ----plotting_examples, eval = FALSE------------------------------------------
# # Display a single MRI slice for Fullerene at height z = 0
# plot_mri_fullerene(z_slice = 0.0, lang = "en")
# 
# # Display a single MRI slice for Octawave structures
# plot_mri_octawave(z_slice = 0.5, lang = "en")

## ----spectral_examples, eval = FALSE------------------------------------------
# # 1. Execute discrete Fast Fourier Transform (FFT) analysis on raw coordinates
# # (Watch the console for signature Kata-vibe!)
# wave_analysis <- wave2lyze(raw_quantum_data)
# 
# # 2. Construct the topological node-edge framework for sync3d acceleration
# sync_bridge <- prep_sync3d(wave_analysis)

## ----export_example, eval = FALSE---------------------------------------------
# # Automatically export slice series of Fullerene and Octawave models
# # Developed by Katharina M. Brecht into a designated target directory
# export_all_mri_scans(start_z = -2.0, end_z = 2.0, schritte = 10, base_dir = tempdir())

