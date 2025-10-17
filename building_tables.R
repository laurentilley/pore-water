# # # # # # # # # # # # # # # # # # # 
# Creating pore water database # # # 
# Created by: Lauren Tilley # # # # # 
# Modified on: 2025-10-17 # # # # # # 
# # # # # # # # # # # # # # # # # # #

# Load packages #### 

library(RSQLite) 
library(DBI)

# Connect to the database ####

porewater_db <- dbConnect(drv = SQLite(),
                           "pore-water.db")

# Create tables ####

dbExecute(conn = porewater_db, 
          statement = "CREATE TABLE sample_site( 
            site_ID varchar(5) PRIMARY KEY NOT NULL UNIQUE,
            block varchar(5),
            plot varchar(5)
            );")

dbExecute(porewater_db, 
          statement = "CREATE TABLE lysimeters( 
          lysimeter_id varchar(5) PRIMARY KEY NOT NULL UNIQUE, 
          site_id varchar(5), 
          install_date text,
          FOREIGN KEY (site_id) REFERENCES sample_site(site_id)
          );")

dbExecute(porewater_db, 
          statement = "CREATE TABLE collections( 
          sample_id varchar(5) PRIMARY KEY NOT NULL UNIQUE, 
          lysimeter_id varchar(5), 
          date_of_collection text, 
          date_of_last_application text, 
          FOREIGN KEY (lysimeter_id) REFERENCES lysimeters(lysimeter_id)
          );")

dbExecute(porewater_db, 
          statement = "CREATE TABLE water( 
          water_id varchar(5) PRIMARY KEY NOT NULL UNIQUE, 
          sample_id varchar(5), 
          ph varchar(3),
          ca_ppm varchar(10),
          k_ppm varchar(10),
          mg_ppm varchar(10), 
          na_ppm varchar(10), 
          p_ppm varchar(10), 
          s_ppm varchar(10), 
          FOREIGN KEY (sample_id) REFERENCES collections(sample_id)
          );")

dbListTables(porewater_db)
    
