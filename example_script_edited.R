#
# example_script_edited.R
#
# This is an example of a script to analyze flow cytometry data in R.
#
# 2020-01-16  WTR
#

# load packages
library(flowCore)
library(wadeTools)
library(fields)     # xline, yline

source("./example_utils.R")   #usually put this at the top of the script

# load the example data in the wadeTools package
filename = system.file("extdata", "example1.fcs", package = "wadeTools")
ff = get_sample(filename)

# count the events in the flowFrame and print out
n_events = nrow(ff)
cat("Number of events in the original file:", n_events, "\n")

# use a function to do the gating, using default parameters
ff_lymph = gate_lymph(fframe = ff)

# count the events in the gated flowFrame and print out
n_events = nrow(ff_lymph)
cat("Number of events in the gated file:", n_events, "\n")


