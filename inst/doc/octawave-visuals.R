## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(octawave)

## ----echo=FALSE, out.width="65%", fig.align="center", fig.cap="Figure 1: Interactive 3D Quantum Field visualization showing the spatial symmetries and overlapping resonance zones of the octawave model."----
# Übergenaue Absicherung von Katha: Falls das Bild fehlt, stürzt der Build nicht ab
if (file.exists("octawave-3d-field.png")) {
  knitr::include_graphics("octawave-3d-field.png")
} else {
  cat("[Image file 'octawave-3d-field.png' not found. Run plot_octawave_3d() interactively to generate this field.]")
}

## ----echo=FALSE, out.width="65%", fig.align="center", fig.cap="Figure 2: Tomographic Fullerene MRI Slice simulation at height z = -1.75, showing complex pentagonal interference patterns."----
if (file.exists("fullerene-mri-slice.jpeg")) {
  knitr::include_graphics("fullerene-mri-slice.jpeg")
} else {
  cat("[Image file 'fullerene-mri-slice.jpeg' not found. Run plot_mri_fullerene(z_slice = -1.75) to view live.]")
}

## ----eval=FALSE, include=TRUE-------------------------------------------------
# library(octawave)
# 
# # Plotting a single horizontal slice at the equator
# plot_mri_octawave(z_slice = 0.0, lang = "en")

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # Simulating the complex C60 fullerene network slice
# plot_mri_fullerene(z_slice = 0.0, lang = "en")

## ----echo=FALSE, eval=TRUE, results='asis'------------------------------------
# Übergenaue Absicherung: Wenn die Dateien da sind, zeige deine HTML-Tabelle
if (file.exists("octawave-time-t1.jpeg") && file.exists("octawave-time-t4.jpeg")) {
  cat('<table style="width:100%; border:none; margin:20px 0;">
  <tr style="border:none;">
    <td style="width:50%; border:none; text-align:center;">
      <img src="octawave-time-t1.jpeg" style="width:100%;" />
    </td>
    <td style="width:50%; border:none; text-align:center;">
      <img src="octawave-time-t4.jpeg" style="width:100%;" />
    </td>
  </tr>
</table>')
} else {
  cat('<p style="text-align:center; font-style:italic; color:#777;">[Time series snapshots omitted or files not found. Active wave processing remains fully functional.]</p>')
}

