#' @title Run Dynamic Quantum MRI Scans
#' @description Launches the automated 80-step Fullerene and Octawave animation sequence directly in the R session.
#' @param sleep_time Numeric. The pause duration between sequential slices in seconds. Defaults to 0.05.
#' @export
run_mri_simulation <- function(sleep_time = 0.05) {

  # 1. Start English version of the scan animation
  message("\U0001f680 Booting MRI scanner... Starting Katharina's Fullerene quantum protocol!")
  for (height in seq(-2.2, 2.2, length.out = 80)) {
    plot_mri_fullerene(z_slice = height, zeitpunkt = 1.0, lang = "en")
    Sys.sleep(sleep_time)
  }
  message("Scan completed successfully. Data sealed in memory.\n")




  # 2. Animation: The classic Octawave octahedron scan
  message("\U0001f680 Starting Katharina's classic Octawave MRI scan... Octahedron protocol active!")
  for (height in seq(-2.2, 2.2, length.out = 80)) {
    plot_mri_octawave(z_slice = height, zeitpunkt = 1.0, lang = "en")
    Sys.sleep(sleep_time)
  }
  message("Octahedron scan finished. Data sealed in memory.")
}

