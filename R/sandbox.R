# Start English version of the scan animation
message("\U0001f680 Booting MRI scanner... Starting Katharina's Fullerene quantum protocol!")

for (height in seq(-2.2, 2.2, length.out = 80)) {
  # lang = "en" for English titles
  plot_mri_fullerene(z_slice = height, zeitpunkt = 1.0, lang = "en")

  Sys.sleep(0.05)
}

message("Scan completed successfully. Data sealed in memory.")








# Animation: The classic Octawave octahedron scan
message("\U0001f680 Starting Katharina's classic Octawave MRI scan... Octahedron protocol active!")

for (height in seq(-2.2, 2.2, length.out = 80)) {
  # Calls the classic octahedron function
  plot_mri_octawave(z_slice = height, zeitpunkt = 1.0, lang = "en")

  # Short pause for smooth visualization
  Sys.sleep(0.05)
}

message("Octahedron scan finished. Data sealed in memory.")

