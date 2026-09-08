#' Geometrische Grundstruktur des Quanten-Oktaeders / Geometric Core Structure of the Quantum Octahedron
#'
#' @description
#' **DEUTSCH:** Berechnet die exakten 3D-Koordinaten der 6 Oktaeder-Scheitelpunkte im Raum.
#'
#' **ENGLISH:** Computes the exact 3D coordinates of the 6 octahedral vertices in space.
#'
#' @import plotly
#' @importFrom graphics persp image locator points
#' @importFrom grDevices colorRampPalette terrain.colors png dev.off pdf
#' @importFrom matlab imagesc zeros
#'
#' @param radius Der Abstand der Ecken vom Nullpunkt (Skalierung des Quanten-Kerns) / The distance of the vertices from the origin (scaling of the quantum core).
#' @return **DEUTSCH:** Eine Matrix mit 6 Zeilen und 3 Spalten (x, y, z), die die räumlichen Koordinaten der Oktaeder-Ecken enthält. / **ENGLISH:** A matrix with 6 rows and 3 columns (x, y, z) containing the spatial coordinates of the octahedral vertices.
#' @export
octa_vertices <- function(radius = 1.0) {
  vertices <- matrix(c(
    radius,  0.0,  0.0,
    -radius,  0.0,  0.0,
    0.0,  radius,  0.0,
    0.0, -radius,  0.0,
    0.0,  0.0,  radius,
    0.0,  0.0, -radius
  ), ncol = 3, byrow = TRUE)
  colnames(vertices) <- c("x", "y", "z")
  return(vertices)
}

#' Neuartige Oktaeder-Quantenwelle mit Raumdaempfung / Novel Octahedral Quantum Wave with Spatial Damping
#'
#' @description
#' **DEUTSCH:** Berechnet die Superposition von Wellen, die von den 6 Ecken eines Oktaeders ausgestrahlt werden, inklusive einer quantenmechanischen Amplitudendaempfung.
#'
#' **ENGLISH:** Computes the superposition of waves radiated from the 6 vertices of an octahedron, including quantum-mechanical amplitude damping.
#'
#' @param x,y,z Die Koordinaten des Punktes im Raum / The coordinates of the point in space.
#' @param freq Die Schwingungsfrequenz der Wellenkomponenten / The vibration frequency of the wave components.
#' @param radius Der Radius des zugrundeliegenden Oktaeders / The radius of the underlying octahedron.
#' @param damping Der Daempfungsfaktor (wie schnell die Welle im Raum abklingt) / The damping factor (how fast the wave decays in space).
#' @return **DEUTSCH:** Ein numerischer Wert oder eine Matrix (je nach Eingabe von x, y, z), der die berechnete Wellenamplitude am gegebenen Punkt darstellt. / **ENGLISH:** A numeric value or matrix (depending on the input of x, y, z) representing the computed wave amplitude at the given spatial coordinates.
#' @export
octa_wave_field <- function(x, y, z, freq = 2.0, radius = 1.5, damping = 0.2) {
  centers <- octa_vertices(radius)
  total_wave <- 0

  for(i in 1:nrow(centers)) {
    r <- sqrt((x - centers[i,"x"])^2 + (y - centers[i,"y"])^2 + (z - centers[i,"z"])^2)
    if(r < 0.01) r <- 0.01

    wave_component <- (sin(freq * r) / r) * exp(-damping * r)
    total_wave <- total_wave + wave_component
  }
  return(total_wave)
}

#' Visualisierung der octawave Quantenwelle / Visualization of the octawave Quantum Wave
#'
#' @description
#' **DEUTSCH:** Erstellt einen automatischen 2D-Schnitt durch das Oktaeder-Wellenfeld im klassischen MATLAB-Stil.
#'
#' **ENGLISH:** Generates an automated 2D cross-section through the octahedral wave field in classic MATLAB style.
#'
#' @param resolution Die Aufloesung des Gitters (hoehere Werte bedeuten feinere Bilder) / The grid resolution (higher values yield finer images).
#' @param range Der sichtbare Bereich auf der X- und Y-Achse / The visible range on the X and Y axes.
#' @return **DEUTSCH:** Keinen Rückgabewert, wird für den Seiteneffekt des Zeichnens einer 2D-Grafik aufgerufen. / **ENGLISH:** No return value, called for the side effect of plotting a 2D image.
#' @export
plot_octawave <- function(resolution = 200, range = 8) {
  space_grid <- seq(-range, range, length.out = resolution)
  wave_matrix <- matlab::zeros(resolution, resolution)

  for(i in 1:resolution) {
    for(j in 1:resolution) {
      wave_matrix[i, j] <- octa_wave_field(space_grid[i], space_grid[j], z = 0, freq = 2.5, radius = 2.0, damping = 0.15)
    }
  }

  matlab::imagesc(wave_matrix, main = "octawave - Lokale Feld-Resonanz (z = 0)")
}

#' Interaktive 3D-Visualisierung der Oktaeder-Welle / Interactive 3D Visualization of the Octahedral Wave
#'
#' @description
#' **DEUTSCH:** Erstellt ein dreidimensionales, interaktives Volumenmodell des Quantenfeldes.
#'
#' **ENGLISH:** Generates a three-dimensional, interactive volume model of the quantum field.
#'
#' @param resolution Die Feinheit des 3D-Gitters (z.B. 30 oder 40) / The density of the 3D grid (e.g., 30 or 40).
#' @param range Der sichtbare Raumbereich (X, Y und Z) / The visible spatial range (X, Y, and Z).
#' @return **DEUTSCH:** Ein interaktives 'plotly'-Objekt, das ein 3D-Volumenmodell darstellt. / **ENGLISH:** An interactive 'plotly' object representing a 3D volume model.
#' @export
plot_octawave_3d <- function(resolution = 35, range = 5) {
  if(!requireNamespace("plotly", quietly = TRUE)) {
    stop("Bitte installiere plotly: install.packages('plotly')")
  }

  gitter_3d <- seq(-range, range, length.out = resolution)
  grid <- expand.grid(x = gitter_3d, y = gitter_3d, z = gitter_3d)

  grid$val <- mapply(octa_wave_field, grid$x, grid$y, grid$z,
                     MoreArgs = list(freq = 2.0, radius = 1.8, damping = 0.1))

  p <- plotly::plot_ly(grid, x = ~x, y = ~y, z = ~z, value = ~val,
                       type = "volume", opacity = 0.15, surface = list(count = 6))
  p <- plotly::layout(p, title = "octawave - Interaktives 3D Quantenfeld")
  return(p)
}

#' @title Time-dependent Octahedron Quantum Wave / Zeitabhaengige Oktaeder-Quantenwelle
#' @description Calculates the wave field at an exact time 't' to simulate dynamic movement.
#' Berechnet das Wellenfeld zu einem exakten Zeitpunkt t, um Bewegung zu simulieren.
#' @param x,y,z Spatial coordinates / Raumkoordinaten.
#' @param t Current time parameter to control wave progression / Aktuelle Zeit steuert das Fortschreiten.
#' @param freq Wave frequency / Schwingungsfrequenz.
#' @param radius Radius of the core octahedron / Radius des Oktaeders.
#' @param damping Damping factor of the quantum wave / Daempfungsfaktor.
#' @return **DEUTSCH:** Ein numerischer Wert oder Vektor, der die Wellenamplitude zum Zeitpunkt t darstellt. / **ENGLISH:** A numeric value or vector representing the wave amplitude at time t.
#' @export
octa_wave_time <- function(x, y, z, t = 0, freq = 2.0, radius = 1.5, damping = 0.1) {
  centers <- matrix(c(
    radius,  0,       0,
    -radius,  0,       0,
    0,       radius,  0,
    0,      -radius,  0,
    0,       0,       radius,
    0,       0,      -radius
  ), ncol = 3, byrow = TRUE)

  total_wave <- 0
  for(i in 1:nrow(centers)) {
    r <- sqrt((x - centers[i,1])^2 + (y - centers[i,2])^2 + (z - centers[i,3])^2)
    r <- ifelse(r < 0.01, 0.01, r)
    wave_component <- (sin(freq * r - t) / r) * exp(-damping * r)
    total_wave <- total_wave + wave_component
  }
  return(total_wave)
}

#' @title Floating 3D Octawave Visualizer / Schwebende 3D-Oktaeder-Quantenwelle
#' @description Plots the quantum wave field at a fixed time step as a beautiful 3D landscape.
#' Zeichnet das Wellenfeld zu einem festen Zeitpunkt als 3D-Landschaft.
#' @param zeitpunkt Fixed time step for the snapshot / Gewaehlter Zeitpunkt fuer die Momentaufnahme.
#' @return **DEUTSCH:** Keinen Rückgabewert, wird für den Seiteneffekt des Zeichnens einer 3D-Perspektive aufgerufen. / **ENGLISH:** No return value, called for the side effect of plotting a 3D perspective.
#' @export
plot_octawave_timesnap_3d <- function(zeitpunkt = 0) {
  resolution <- 60
  space_grid <- seq(-5, 5, length.out = resolution)

  wave_matrix <- matrix(0, nrow = resolution, ncol = resolution)
  for(i in 1:resolution) {
    for(j in 1:resolution) {
      wave_matrix[i, j] <- octa_wave_time(space_grid[i], space_grid[j], z = 0, t = zeitpunkt, freq = 2.5, radius = 2.0)
    }
  }

  matlab_colors <- colorRampPalette(c("blue", "cyan", "green", "yellow", "red"))(100)

  persp(space_grid, space_grid, wave_matrix,
        theta = 35, phi = 30,
        expand = 0.6, ltheta = 120,
        shade = 0.45, tcl = -0.2,
        col = matlab_colors[cut(wave_matrix, 100)],
        main = paste("octawave 3D - Time / Zeit t =", round(zeitpunkt, 2)),
        xlab = "X-Quantum", ylab = "Y-Quantum", zlab = "Amplitude",
        border = NA)
}

#' @title Export 3D Octawave Snapshot Series / 3D-Bilder-Serie exportieren
#' @description Saves a series of 3D snapshots as PNG files to visualize the wave progression.
#' Speichert eine Serie von 3D-Momentaufnahmen als PNG-Dateien, um das Fortschreiten zu zeigen.
#' @param count Number of images to export / Anzahl der Bilder, die gespeichert werden sollen.
#' @param output_dir Target directory for exported files / Zielordner für die exportierten Dateien.
#' @return **DEUTSCH:** Keinen Rückgabewert, schreibt PNG-Dateien in das angegebene Verzeichnis. / **ENGLISH:** No return value, writes PNG files to the specified directory.
#' @export
export_octawave_series <- function(count = 5, output_dir = tempdir()) {
  zeit_punkte <- seq(0, pi, length.out = count)

  for(i in 1:count) {
    file_name <- file.path(output_dir, paste0("octawave_snapshot_", i, ".png"))
    png(file_name, width = 800, height = 800, res = 120)
    plot_octawave_timesnap_3d(zeitpunkt = zeit_punkte[i])
    dev.off()
  }
  message(paste("Successfully saved", count, "images to standard output directory."))
}

#' @title Interactive Drop Zone / Interaktives Mausklick-Cockpit
#' @description Allows the user to click into the plot to trigger a new wave at that exact coordinate.
#' Erlaubt es, per Mausklick eine neue Welle an der gewaehlten Koordinate auszuloesen.
#' @return **DEUTSCH:** Keinen Rückgabewert, wird für interaktive Plots im Grafikfenster genutzt. / **ENGLISH:** No return value, called for interactive plotting side effects.
#' @export
interactive_octawave <- function() {
  resolution <- 100
  space_grid <- seq(-5, 5, length.out = resolution)

  wave_matrix <- matrix(0, nrow = resolution, ncol = resolution)
  for(i in 1:resolution) {
    for(j in 1:resolution) {
      wave_matrix[i, j] <- octa_wave_time(space_grid[i], space_grid[j], z = 0, t = 0, freq = 2.5, radius = 2.0)
    }
  }

  matlab_colors <- colorRampPalette(c("blue", "cyan", "green", "yellow", "red"))(100)

  image(space_grid, space_grid, wave_matrix, col = matlab_colors, asp = 1,
        main = "Klicke in die Grafik fuer einen neuen Einschlag!",
        xlab = "X-Raum", ylab = "Y-Raum")

  message("Bitte klicke jetzt einmal mit der Maus irgendwo in das 'Plots'-Fenster...")

  klick <- locator(n = 1)

  if(!is.null(klick)) {
    new_x <- klick$x
    new_y <- klick$y

    message(paste("Einschlag registriert bei X =", round(new_x, 2), "und Y =", round(new_y, 2)))

    new_matrix <- matrix(0, nrow = resolution, ncol = resolution)
    for(i in 1:resolution) {
      for(j in 1:resolution) {
        dx <- space_grid[i] - new_x
        dy <- space_grid[j] - new_y
        new_matrix[i, j] <- octa_wave_time(dx, dy, z = 0, t = 1.2, freq = 2.5, radius = 2.0)
      }
    }

    image(space_grid, space_grid, new_matrix, col = matlab_colors, asp = 1,
          main = paste("Neue Quantenwelle bei X =", round(new_x, 1), "Y =", round(new_y, 1)),
          xlab = "X-Raum", ylab = "Y-Raum")
  }
}

#' @title Interactive Multi-Drop 3D Zone / Interaktive 3D-Mehrfach-Klick-Zone
#' @description Allows the user to click 3 times to create overlapping waves in the 3D landscape.
#' Erlaubt 3 Mausklicks, um sich ueberlagernde Wellen in einer 3D-Landschaft zu erzeugen.
#' @return **DEUTSCH:** Keinen Rückgabewert, zeichnet eine interaktive 3D-Perspektive nach 3 Mausklicks. / **ENGLISH:** No return value, plots a 3D perspective after 3 interactive mouse clicks.
#' @export
interactive_multi_3d <- function() {
  resolution <- 60
  space_grid <- seq(-5, 5, length.out = resolution)
  matlab_colors <- colorRampPalette(c("blue", "cyan", "green", "yellow", "red"))(100)

  image(space_grid, space_grid, matrix(0, resolution, resolution), col = matlab_colors, asp = 1,
        main = "Klicke nacheinander 3x in die Grafik!", xlab = "X", ylab = "Y")

  message("Bitte klicke jetzt nacheinander 3x in das 'Plots'-Fenster...")

  klicks <- list(x = c(), y = c())
  for(k in 1:3) {
    pt <- locator(n = 1)
    if(!is.null(pt)) {
      klicks$x <- c(klicks$x, pt$x)
      klicks$y <- c(klicks$y, pt$y)
      points(pt$x, pt$y, col = "white", pch = 19, cex = 1.5)
      message(paste("Klick", k, "registriert!"))
    }
  }

  wave_matrix <- matrix(0, nrow = resolution, ncol = resolution)
  for(i in 1:resolution) {
    for(j in 1:resolution) {
      total_val <- 0
      for(k in 1:length(klicks$x)) {
        dx <- space_grid[i] - klicks$x[k]
        dy <- space_grid[j] - klicks$y[k]
        total_val <- total_val + octa_wave_time(dx, dy, z = 0, t = 1.0, freq = 2.5, radius = 2.0)
      }
      wave_matrix[i, j] <- total_val
    }
  }

  persp(space_grid, space_grid, wave_matrix,
        theta = 35, phi = 30, expand = 0.6, ltheta = 120, shade = 0.45,
        col = matlab_colors[cut(wave_matrix, 100, labels = FALSE)],
        main = "3D-Quantenraum nach 3 Einschlaegen", border = NA)
}

#' @title Fullerene Gitternetz MRT-Scan / Pentagon-Hexagon Wave Slice
#' @description Scans a complex 5- and 6-edged quantum grid layer by layer with bilingual support.
#' @param z_slice Die Hoehe des MRT-Schnitts (von -2.5 bis +2.5)
#' @param zeitpunkt Der aktuelle Zeitschritt der Welle (t)
#' @param lang Sprache fuer den Plot: "de" fuer Deutsch, "en" fuer Englisch
#' @return **DEUTSCH:** Keinen Rückgabewert, zeichnet eine 2D-Schnittfläche der Fullerene-Struktur. / **ENGLISH:** No return value, plots a 2D slice of the fullerene wave structure.
#' @export
plot_mri_fullerene <- function(z_slice = 0, zeitpunkt = 1.0, lang = "de") {
  phi <- (1 + sqrt(5)) / 2

  coords <- matrix(c(
    0, 1, 3*phi,   0, 1, -3*phi,  0, -1, 3*phi,  0, -1, -3*phi,
    1, 3*phi, 0,   1, -3*phi, 0,  -1, 3*phi, 0,  -1, -3*phi, 0,
    3*phi, 0, 1,   3*phi, 0, -1,  -3*phi, 0, 1,  -3*phi, 0, -1
  ), ncol = 3, byrow = TRUE)

  vertices <- coords / max(coords) * 2.0
  colnames(vertices) <- c("x", "y", "z")

  grid_size <- 150
  x_vec <- seq(-3, 3, length.out = grid_size)
  y_vec <- seq(-3, 3, length.out = grid_size)
  grid <- expand.grid(X = x_vec, Y = y_vec)

  wellen_matrix <- matrix(0, nrow = grid_size, ncol = grid_size)

  for(i in 1:nrow(vertices)) {
    dx <- grid$X - vertices[i, "x"]
    dy <- grid$Y - vertices[i, "y"]
    dz <- z_slice - vertices[i, "z"]

    r <- sqrt(dx^2 + dy^2 + dz^2)
    amplitude <- sin(5 * r - zeitpunkt) / (r + 0.5)
    wellen_matrix <- wellen_matrix + matrix(amplitude, nrow = grid_size, ncol = grid_size)
  }

  if (lang == "en") {
    titel <- paste("Fullerene MRI Scan | Slice Height z =", round(z_slice, 2))
    x_lbl <- "X-Axis (Quantum Space)"
    y_lbl <- "Y-Axis (Quantum Space)"
  } else {
    titel <- paste("Fullerene MRT-Scan | Schichthoehe z =", round(z_slice, 2))
    x_lbl <- "X-Achse (Quantenraum)"
    y_lbl <- "Y-Achse (Quantenraum)"
  }

  image(x_vec, y_vec, wellen_matrix,
        col = terrain.colors(100),
        main = titel,
        xlab = x_lbl, ylab = y_lbl,
        asp = 1, axes = TRUE)
}

#' @title Klassischer Oktaeder-MRT-Scan / Octawave Wave Slice
#' @description Scans Katharina's original 6-cornered octawave geometry layer by layer.
#' @param z_slice Die Hoehe des MRT-Schnitts (von -2.5 bis +2.5)
#' @param zeitpunkt Der aktuelle Zeitschritt der Welle (t)
#' @param lang Sprache fuer den Plot: "de" fuer Deutsch, "en" fuer Englisch
#' @return **DEUTSCH:** Keinen Rückgabewert, zeichnet eine 2D-Schnittfläche des Oktaeder-Wellenfelds. / **ENGLISH:** No return value, plots a 2D slice of the octahedral wave field.
#' @export
plot_mri_octawave <- function(z_slice = 0, zeitpunkt = 1.0, lang = "de") {
  vertices <- matrix(c(
    0,  0,  2,
    0,  0, -2,
    2,  0,  0,
    -2,  0,  0,
    0,  2,  0,
    0, -2,  0
  ), ncol = 3, byrow = TRUE)
  colnames(vertices) <- c("x", "y", "z")

  grid_size <- 150
  x_vec <- seq(-3, 3, length.out = grid_size)
  y_vec <- seq(-3, 3, length.out = grid_size)
  grid <- expand.grid(X = x_vec, Y = y_vec)

  wellen_matrix <- matrix(0, nrow = grid_size, ncol = grid_size)

  for(i in 1:nrow(vertices)) {
    dx <- grid$X - vertices[i, "x"]
    dy <- grid$Y - vertices[i, "y"]
    dz <- z_slice - vertices[i, "z"]

    r <- sqrt(dx^2 + dy^2 + dz^2)
    amplitude <- sin(5 * r - zeitpunkt) / (r + 0.5)
    wellen_matrix <- wellen_matrix + matrix(amplitude, nrow = grid_size, ncol = grid_size)
  }

  if (lang == "en") {
    titel <- paste("Classic Octawave MRI Scan | Slice Height z =", round(z_slice, 2))
    x_lbl <- "X-Axis (Quantum Space)"
    y_lbl <- "Y-Axis (Quantum Space)"
  } else {
    titel <- paste("Klassischer Octawave MRT-Scan | Schichthoehe z =", round(z_slice, 2))
    x_lbl <- "X-Achse (Quantenraum)"
    y_lbl <- "Y-Achse (Quantenraum)"
  }

  image(x_vec, y_vec, wellen_matrix,
        col = terrain.colors(100),
        main = titel,
        xlab = x_lbl, ylab = y_lbl,
        asp = 1, axes = TRUE)
}



#' @title Export 3D Octawave Snapshot Series / 3D-Bilder-Serie exportieren
#' @description Saves a series of Fullerene and Octawave MRI slices as PNGs and PDFs.
#' @param start_z Start height of the slices / Start-Hoehe.
#' @param end_z End height of the slices / End-Hoehe.
#' @param schritte Number of images per series / Anzahl der Schichten.
#' @param base_dir Base target directory for exported folders / Basis-Zielverzeichnis.
#' @return **DEUTSCH:** Keinen Rückgabewert, schreibt PNG- und PDF-Dateien in temporäre Ordner. / **ENGLISH:** No return value, exports PNG and PDF files to designated temporary paths.
#' @export
export_all_mri_scans <- function(start_z = -2, end_z = 2, schritte = 10, base_dir = tempdir()) {

  # Hier steht jetzt stolz dein Name in den Ordnern!
  dir_fullerene <- file.path(base_dir, "Kathas_Fullerene_Quantum_Export")
  dir_octawave  <- file.path(base_dir, "Kathas_Octawave_Quantum_Export")

  if (!dir.exists(dir_fullerene)) dir.create(dir_fullerene, recursive = TRUE)
  if (!dir.exists(dir_octawave))  dir.create(dir_octawave, recursive = TRUE)

  z_werte <- seq(start_z, end_z, length.out = schritte)

  for(i in 1:length(z_werte)) {
    png(filename = file.path(dir_fullerene, paste0("Kathas_Fullerene_Slice_", i, ".png")), width = 800, height = 800, res = 150)
    plot_mri_fullerene(z_slice = z_werte[i], lang = "de")
    dev.off()
  }

  pdf(file = file.path(dir_fullerene, "Kathas_Fullerene_Quantum_Presentation.pdf"), width = 7, height = 7)
  for(i in 1:length(z_werte)) {
    plot_mri_fullerene(z_slice = z_werte[i], lang = "de")
  }
  dev.off()

  for(i in 1:length(z_werte)) {
    png(filename = file.path(dir_octawave, paste0("Kathas_Octawave_Slice_", i, ".png")), width = 800, height = 800, res = 150)
    plot_mri_octawave(z_slice = z_werte[i], lang = "de")
    dev.off()
  }

  pdf(file = file.path(dir_octawave, "Kathas_Octawave_Quantum_Presentation.pdf"), width = 7, height = 7)
  for(i in 1:length(z_werte)) {
    plot_mri_octawave(z_slice = z_werte[i], lang = "de")
  }
  dev.off()

  message("\U0001f680 Both snapshot series exported successfully into Kathas temporary directory paths!")
}



