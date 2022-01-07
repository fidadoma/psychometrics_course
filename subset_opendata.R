library(tidyverse)

set.seed(1)

read_csv("data/ECR/ECR.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/ECR/ECR.xlsx")

read_csv("data/MSSCQ/MSSCQ.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/MSSCQ/MSSCQ.xlsx")

read_tsv("data/NPAS/NPAS.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/NPAS/NPAS.xlsx")

set.seed(2)

read_tsv("data/RSE/RSE.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/RSE/RSE.xlsx")

set.seed(3)

read_tsv("data/SD3/SD3.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/SD3/SD3.xlsx")

set.seed(4)

read_csv("data/TMA/TMA.csv") %>% 
  sample_n(1500) %>% 
  writexl::write_xlsx("data/TMA/TMA.xlsx")
