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

nhanes_small %>%
  select(
    bp_sys_ave,
    education
  )

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

# select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(bmi, age)

# blood_pressure <- select(nhanes_small, starts_with("bp_"))
# rename(blood_pressure, bp_systolic = bp_sys)

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)

# Filtering rows ----------------------------------------------------------
nhanes_small %>%
  filter(phys_active != "No")

# "|" is OR, "," is &; be careful with OR

nhanes_small %>%
  filter(
    bmi >= 25,
    phys_active == "No"
  )

nhanes_small %>%
  filter(bmi >= 25 |
    phys_active == "No")

# Arranging rows ----------------------------------------------------------

# desc(age)

nhanes_small %>%
  arrange(desc(age), bmi, education)

# Mutating columns --------------------------------------------------------

nhanes_update <- nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4,
    old = if_else(
      age >= 30,
      "old",
      "young"
    )
  )

# Exercise 7.12 -----------------------------------------------------------
# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
  # Format should follow: variable >= number or character
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
  mutate(
    # 2. Calculate mean arterial pressure
    mean_arterial_pressure = ((2 * bp_dia_ave) + bp_sys_ave) / 3,
    # 3. Create young_child variable using a condition
    young_child = if_else(age < 6, "Yes", "No")
  )

nhanes_modified

# Summarising -------------------------------------------------------------

# summarise only gives columns it's asked for and only one row

nhanes_small %>%
  group_by(diabetes) %>%
  summarize(
    max_bmi = max(bmi, na.rm = TRUE),
    min_bmi = min(bmi, na.rm = TRUE)
  )

nhanes_small %>%
  filter(!is.na(diabetes)) %>%
  group_by(
    diabetes,
    phys_active
  ) %>%
  summarize(
    max_bmi = max(bmi, na.rm = TRUE),
    min_bmi = min(bmi, na.rm = TRUE)
  ) %>%
    ungroup()

write_csv(
    nhanes_small,
    here::here("data/nhanes_small.csv")
)


