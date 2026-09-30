# octawave 0.1.1
* Added `wave2lyze()` for core quantum wave spectral analysis using Discrete Fast Fourier Transforms (FFT).
* Added `prep_sync3d()` to build the topological node-edge framework required for high-performance WebGL acceleration.
 * Integrated a comprehensive English package vignette (`octawave-wave2lyze-interface.Rmd`) detailing this new 3D synchronization pipeline.
* Refactored the automated 80-step MRI simulation loops into an explicit, exported function `run_mri_simulation()`, making the animation sequence significantly more accessible directly within the R session.

# octawave 0.1.0
* Initial release on CRAN.
* Released the core framework of the 'octawave' package.
* Added mathematical tools for simulating and visualizing three-dimensional octahedral quantum wave interferences.
* Implemented virtual MRI slice generation and automated multi-format export for both Fullerene and Octawave spatial structures.
