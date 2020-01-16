#
# example_utils.R
#
# This is an example of a file containing function declarations.
# Remember to select "Source on Save".
#
# 2020-01-16  WTR

# function: gate_lymph
# This function gates lymphocytes using FSC-A and SSC-A
# We note a large "debris" peak near zero, so we'll filter that out first before
# trying to find a contour around the lymphocyte blob.
gate_lymph = function(fframe, thresh_debris_fsc = 0.25, thresh_debris_ssc = 0.25,
                      location = c(2, 1), height = 0.5, show = TRUE) {

  # packages needed to be loaded to execute this function
  require("flowCore")
  require("wadeTools")
  require("fields")

  # 1.  Calculate a polygon gate
  tmp = Subset(fframe, rectangleGate("FSC-A" = c(thresh_debris_fsc, Inf), "SSC-A" = c(thresh_debris_ssc, Inf)))
  bb = blob.boundary(ff = tmp, parameters = c("FSC-A", "SSC-A"), location = location, height = height, convex = TRUE)
  pg = polygonGate(.gate = bb)

  # 2. visualize the gating procedure
  pplot(fframe, c("FSC-A","SSC-A"), tx = 'linear', ty = 'linear')
  lines(bb, lwd = 2)                          # draw the blob contour on top of the figure
  xline(thresh_debris_fsc, lty = 'dotdash')   # show the debris thresholds
  yline(thresh_debris_ssc, lty = 'dotdash')

  # 3. apply the gate to get a result
  ff_lymph = Subset(fframe, pg)

  # return the resulting flowFrame
  ff_lymph
}










