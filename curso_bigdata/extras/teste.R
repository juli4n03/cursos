library("data.table")

TB_FAST_MODEL <- fread(file = "C:/Sicredi/trat_portfolio_obx_v3.csv")
save(TB_FAST_MODEL, file = "C:/Sicredi/0.RData")
