# octawave: Dynamic 3D Quantum Waves

<pre>
+-------------------------------------------------------+

|   o c t a w a v e                                     |
|   >> Multidimensional Wave & Scalar Field Computing   |
+-------------------------------------------------------+

|   Core Developer: Katharina Maria Brecht (2026)       |
+-------------------------------------------------------+
</pre>

This project simulates dynamic, time-dependent quantum wave fields based on an octahedral structure.

### The Origin / Der Ursprung
This system was born from a vivid night-time dream about geometric structures, waves, and collapsing spaces. It is the transition of sub-conscious creative energy into real, working mathematical R code.

### License & Academic Identity / Schutz & Akademische Identität
Copyright (C) 2026 Katharina M. Brecht.  
**ORCID iD:** [https://orcid.org/0009-0001-2176-7476](https://orcid.org/0009-0001-2176-7476)

Protected under the GNU General Public License v3 (GPL-3.0).  
Anyone using or modifying this code MUST credit Katharina M. Brecht (ORCID: 0009-0001-2176-7476) as the original author.

---

## Research Abstract & Core Objectives

The `'octawave'` package transcends traditional, static modeling constraints by introducing an applicable framework for three-dimensional (3D) quantum geometry visualization within the R statistical environment.

* **Physical Assertion:** Quantum waves and resonance fields are inherently dynamic, spatial geometries defined by complex multi-dimensional symmetries (such as octahedral vertex networks).
* **Methodology:** Through the application of virtual Magnetic Resonance Imaging (MRI) slicing techniques, this framework transforms highly complex mathematical equations into dynamic, interactive, and visually tangible spacetime models.
* **Open Science Impact:** By providing full reproducibility via open-source R code, this project democratizes advanced quantum geometry—proving that complex spatial interferences can be fully simulated, visualized, and examined on any standard system globally.

---

## Package Features & Functionalities

### 1. Core Computations
* **Scaling of the Quantum Core:** Computes the exact 3D coordinates of the six octahedral vertices in space based on their distance from the origin.
* **Novel Octahedral Quantum Wave with Spatial Damping:** Computes the superposition of waves radiated from the six vertices of an octahedron, integrating quantum-mechanical amplitude damping.
* **Time-dependent Octahedron Quantum Wave:** Calculates the wave field at an exact time step 't' to simulate dynamic movements and quantum state progressions.

### 2. Virtual Slicing & Grids
* **Pentagon-Hexagon Wave Slice:** Scans a complex 5- and 6-edged quantum grid layer by layer, featuring built-in bilingual support.
* **Octawave Wave Slice:** Scans Katharina's original 6-cornered octawave geometry layer by layer using virtual slicing.
* **Export Full Wave Slice Series:** Exports a complete series of Fullerene and OCTAWAVE MRI slices as high-resolution PNGs and PDFs.

### 3. Graphics & UX
* **Visualization of the Octawave Quantum Field:** Generates an automated, publication-quality 2D cross-section through the octahedral wave field in classic MATLAB aesthetics.
* **Interactive 3D Visualization of the Octahedral Wave:** Generates a three-dimensional, interactive volume model of the quantum field for real-time exploration via `'plotly'`.
* **Floating 3D Octawave Visualizer:** Plots the quantum wave field at a fixed time step, rendering it as a stunning, continuous 3D landscape.
* **Export 3D Octawave Snapshot Series:** Saves a sequential series of 3D snapshots as PNG files to capture and visualize continuous wave progression.
* **Interactive Drop Zone:** Allows users to click directly into the plot to trigger and seed a new wave at that exact physical coordinate.
* **Interactive Multi-Drop 3D Zone:** Allows users to click three sequential times to dynamically create and overlay overlapping waves within the 3D landscape.

### 4. Advanced Spectral Analysis & WebGL Acceleration (New in v0.1.1)
* **Core Spectral Analysis (`wave2lyze`):** Processes multidimensional spatial coordinates to extract Euclidean amplitudes and applies Fast Fourier Transforms (FFT) to decode hidden quantum interference patterns. 
* **Topological WebGL Interface (`prep_sync3d`):** Bridges the analytical results of octawave with the 'sync3d' engine. It auto-generates localized node-edge structures for high-performance, frame-accurate 3D rendering, completely bypassing standard browser lag.

---

## Advanced Feature: Quantum Wave Analysis & sync3d Integration

The latest update introduces `wave2lyze` and `prep_sync3d`, forming a direct topological bridge to the **sync3d** package. By transforming spectral analysis data into optimized node-edge matrices, it unlocks high-performance, hardware-accelerated 3D WebGL rendering through the `add_synchronized_3d_edges()` pipeline without browser lag.

### Quick Start: 3D Quantum Wave Synchronization

```r
library(octawave)
library(plotly)
library(sync3d)

# 1. Simulate complex harmonic wave data
time_vec <- seq(0, 4 * pi, length.out = 100)
raw_quantum_data <- data.frame(X = sin(time_vec), Y = cos(time_vec))

# 2. Analyze phase space and generate the topological bridge
analysis <- wave2lyze(raw_quantum_data)
sync_data <- prep_sync3d(analysis)

# 3. Render synchronized structure via the sync3d engine
base_plot <- plot_ly(data = sync_data$nodes, x = ~x, y = ~y, z = ~z,
                     type = 'scatter3d', mode = 'markers',
                     marker = list(size = 4, color = '#008080'))

final_plot <- add_synchronized_3d_edges(base_plot, sync_data$edges)
final_plot
```

---

## Installation

You can install the official released version of **octawave** directly from CRAN with:

```r
install.packages("octawave")
```

