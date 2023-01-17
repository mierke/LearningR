# Just testing conflicts.
10

# R basics ----------------------------------------------------------------

weight_kilos <- 100
weight_kilos <- 10

weight_kilos

colnames(airquality)

str(airquality)

summary(airquality)

2 + 2 # control + shift + P to get to options -> style active file

2 + 2 # or ctrl + shift + A

# Packages ----------------------------------------------------------------
library(tidyverse)
library(NHANES)

# Looking at data ---------------------------------------------------------
glimpse(NHANES)
colnames(NHANES)

select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc) # To exclude a variable

select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("Age"))

nhanes_small <- select(
  NHANES,
  Age,
  Gender,
  BMI,
  Diabetes,
  PhysActive,
  BPSysAve,
  BPDiaAve,
  Education
)
nhanes_small

# Fixing variable names ---------------------------------------------------

nhanes_small <- rename_with(
  nhanes_small,
  snakecase::to_snake_case
)
nhanes_small

# rename one variable at a time
nhanes_small <- rename(
  nhanes_small,
  sex = gender
)

# Piping ------------------------------------------------------------------

# Ctrl + Shift + M for pipe %>%

colnames(nhanes_small)

nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)
