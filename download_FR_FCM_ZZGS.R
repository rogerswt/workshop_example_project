#
# download_FR-FCM-ZZGS.R
#
# Download a FlowRepository dataset.
#
# Please execute this script BEFORE next session.
#
# 2020-01-16  WTR
#

library(FlowRepositoryR)

# data_base = "specify a directory on your computer where you want to locate the data"
data_base = "~/Data/young_old"

ds = flowRep.get("FR-FCM-ZZGS", use.credentials = FALSE)
res = download(ds, dirpath = data_base, show.progress = TRUE)






