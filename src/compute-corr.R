# compute-corr.R
# Matt Kmiecik
# Purpose: prepares data and computes zero-order correlations for PCA measures

# libraries ----
library(tidyverse)

# data ----
f <-  list.files(path = "data", pattern = "*-pca-data.csv", full.names = TRUE) 
data <- 
  as.list(f) %>% 
  map(~read_csv(file = .x)) %>% 
  reduce(full_join, by = join_by(ss)) %>%
  # removes volume meas and coldpain (use coldpain_resid instead)
  select(-ends_with("_vol"), -coldpain) 

# filters out incomplete data
pca_data_discard  <- data %>% filter(!complete.cases(.)) # 153 discarded
pca_data_keep     <- data %>% filter(complete.cases(.))  # 200 kept

# correlation procedure ----
cor_data <- as.matrix(pca_data_keep[,-1]) # removes subject id col
res <- Hmisc::rcorr(cor_data, type = "pearson")
res[["data"]] <- pca_data_keep

# writing zero-order correlations as rds to file ----
if (!dir.exists("output")) {
  cat("The directory output/ was created.\n")
  dir.create("output")
} else{
  cat("The directory output/ already exists; skipping...\n")
}
f <- file.path("output", "cor-res.rds")
write_rds(res, file = f)

# writing individual CSV files ----

# converting correlation coefficients to data frame for control of presentation
res$r <- as_tibble(res$r, rownames = "meas")
res$n <- as_tibble(res$n, rownames = "meas")
res$P <- as_tibble(res$P, rownames = "meas")
res$type <- as_tibble(res$type) %>% rename(corr_method = value)

# loops through and saves individual CSV files
for (i in seq_along(res)) {
  this_name <- names(res[i])
  f <- file.path("output", glue::glue("cor-res-{this_name}.csv"))
  save_obj <- res[[i]]
  write_csv(save_obj, f)
}

cat("Script has finished running.\n")
