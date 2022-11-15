library(tidyverse)

set.seed(123)


n_vars <- 5
n_cols <- n_vars*2
variables <- rep(c(TRUE,F),n_vars)
errors <- rep(c(F,TRUE),n_vars)

m <- matrix(rep(0,(n_cols)^2), ncol = n_cols)

low_cor  <- 0.7
high_cor <- 0.8

inter_cor <- runif(length(m[variables,variables]),
                   min = low_cor,max = high_cor)
                   
m[variables,variables] <- inter_cor
m[lower.tri(m)] <- t(m)[lower.tri(m)]
diag(m) <- 1

n <- 1000
mean_T <- 50
sd_T <- 5
mus <- rep(c(mean_T,0),n_vars)
sds <- rep(c(sd_T,5),n_vars)
finished <- F
while (!finished) {
  finished <- TRUE
  tolerance <- 1e-5
  
  df <- rnorm_multi(n = n, 
                    mu = mus,
                    sd = sds,
                    r = m, 
                    varnames = apply(expand.grid(c("T","E"), 1:n_vars), 1, paste, collapse=""),
                    empirical = TRUE) %>% 
    mutate(T1 = round(T1),
           E1 = round(E1),
           T2 = round(T2),
           E2 = round(E2),
           T3 = round(T3),
           E3 = round(E3),
           T4 = round(T4),
           E4 = round(E4),
           T5 = round(T5),
           E5 = round(E5))
  #if((cor(df$T,df$E) > tolerance) | abs(mean(df$E)) > tolerance) {
  #  finsihed <- F
  #}
  
  
}
df <- df %>% 
  mutate(sex = c(rep("male",each=500), rep("female",each=500)),.before = T1) %>% 
  mutate(T1 = if_else(sex == "male", T1+5, T1),
         T2 = if_else(sex == "male", T2+5, T2),
         T3 = if_else(sex == "male", T3+5, T3),
         T4 = if_else(sex == "male", T4+5, T4),
         T5 = if_else(sex == "male", T5+5, T5))
df <- df %>% 
  mutate(subject_id = 1:n(), .before = sex) %>% 
  mutate(Ot1 = T1+E1,
         Ot2 = T2+E2,
         Ot3 = T3+E3,
         Ot4 = T4+E4,
         Ot5 = T5+E5) %>% 
  mutate(Hs = Ot1+Ot2+Ot3+Ot4+Ot5,
         T= T1 + T2 +T3 +T4 +T5,
         E= E1 + E2 +E3 +E4 +E5) %>% 
  as_tibble()

writexl::write_xlsx(df, here::here("data/reliability_full.xlsx"))
writexl::write_xlsx(df %>% select(subject_id,Ot1:Ot5), here::here("data/reliability.xlsx"))

psych::alpha(df %>% select(Ot1:Ot5))
var(df$T)/(var(df$T) + var(df$E))
cor(df$T,df$Hs)^2
1-cor(df$E,df$Hs)^2

