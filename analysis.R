install.packages("tidyverse")

library(tidyverse)

# Load raw data
facilities <- read_csv("Raw Data/Data_Download_ECHO_7_5_2026_6a49dc902514c.csv")
complaints <- read_csv("Raw Data/CDPH_Environmental_Complaints_20260705.csv")
enforcement <- read_csv("Raw Data/CDPH_Environmental_Enforcement.csv")
health <- read_csv("Raw Data/PLACES__Local_Data_for_Better_Health,_Census_Tract_Data,_2025_release_20260705.csv")
poverty <- read_csv("Raw Data/ACSST1Y2024.S1701-2026-07-05T053037.csv")

# --- CLEAN COMPLAINTS ---
complaints_clean <- complaints %>%
  filter(!is.na(LATITUDE), !is.na(LONGITUDE)) %>%
  select(COMPLAINT_TYPE = `COMPLAINT TYPE`,
         RESOLUTION,
         LATITUDE,
         LONGITUDE)

# --- CLEAN ENFORCEMENT ---
enforcement_clean <- enforcement %>%
  filter(!is.na(LATITUDE), !is.na(LONGITUDE)) %>%
  select(VIOLATION_TYPE = `CODE VIOLATION`,
         DISPOSITION,
         FINE_AMOUNT = `FINE AMOUNT`,
         LATITUDE,
         LONGITUDE)

# --- CLEAN FACILITIES ---
facilities_clean <- facilities %>%
  filter(FacCity == "CHICAGO") %>%
  select(NAME = FacName,
         STREET = FacStreet,
         VIOLATIONS = FacQtrsWithNC,
         INSPECTIONS = FacInspectionCount,
         FORMAL_ACTIONS = FacFormalActionCount)

# --- CLEAN HEALTH (filter to Cook County, key measures) ---
health_clean <- health %>%
  filter(CountyName == "Cook",
         Short_Question_Text %in% c("Current Asthma", "COPD", "Life Expectancy")) %>%
  select(LocationName, Measure = Short_Question_Text,
         Data_Value, Geolocation)

# --- EXPORT FOR TABLEAU ---
write_csv(complaints_clean, "Processed Data/complaints_clean.csv")
write_csv(enforcement_clean, "Processed Data/enforcement_clean.csv")
write_csv(facilities_clean, "Processed Data/facilities_clean.csv")
write_csv(health_clean, "Processed Data/health_clean.csv")

write_csv(complaints_clean, "Processed Data/complaints_clean.csv")

names(complaints)
names(enforcement)