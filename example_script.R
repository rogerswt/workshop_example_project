#
# example_script.R
#
# This is an example of a script to analyze flow cytometry data in R.
#
# 2020-01-16  WTR
#

# load packages
library(flowCore)
library(wadeTools)
library(fields)     # xline, yline

# load the example data in the wadeTools package
filename = system.file("extdata", "example1.fcs", package = "wadeTools")
ff = get_sample(filename)

# count the events in the flowFrame and print out
n_events = nrow(ff)
cat("Number of events in the original file:", n_events, "\n")

# make a picture
pplot(ff, c("FSC-A","SSC-A"), tx = 'linear', ty = 'linear')

# INLINE:  gate lymphocytes
# 1.  Calculate a polygon gate
thresh_debris_fsc = 0.25
thresh_debris_ssc = 0.25
tmp = Subset(ff, rectangleGate("FSC-A" = c(thresh_debris_fsc, Inf),
                               "SSC-A" = c(thresh_debris_ssc, Inf)
                               )
             )
bb = blob.boundary(ff = tmp, parameters = c("FSC-A", "SSC-A"),
                   location = c(2, 1), height = .5, convex = TRUE
                   )
pg = polygonGate(.gate = bb)

# 2. visualize the gating procedure
pplot(ff, c("FSC-A","SSC-A"), tx = 'linear', ty = 'linear')
lines(bb, lwd = 2)                          # draw the blob contour on top of the figure
xline(thresh_debris_fsc, lty = 'dotdash')   # show the debris thresholds
yline(thresh_debris_ssc, lty = 'dotdash')

# 3. apply the gate to get a result
ff_lymph = Subset(ff, pg)

# count the events in the gated flowFrame and print out
n_events = nrow(ff_lymph)
cat("Number of events in the gated file:", n_events, "\n")

################################################################################
# # Create a FUNCTION to gate lymphocytes
################################################################################

# source("./example_utils.R")   #usually put this at the top of the script
# ff_lymph = gate_lymph(fframe = ff)

# # experiment with the function's parameters
# ff_lymph_1 = gate_lymph(fframe = ff, height = 0.7)
# ff_lymph_2 = gate_lymph(fframe = ff, thresh_debris_fsc = .5)




