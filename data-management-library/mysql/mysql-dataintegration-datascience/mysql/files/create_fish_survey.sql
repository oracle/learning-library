CREATE DATABASE IF NOT EXISTS nature;
USE nature;
DROP TABLE IF EXISTS fish;
CREATE TABLE fish (
  fid VARCHAR(100) UNIQUE,
  key_id VARCHAR(100),
  survey_id VARCHAR(15),
  country VARCHAR(50),
  ecoregion VARCHAR(100),
  realm VARCHAR(150),
  site_code VARCHAR(9),
  site_name VARCHAR(100),
  site_lat VARCHAR(10),
  site_long VARCHAR(10),
  survey_date VARCHAR(20),
  depth VARCHAR(10),
  phylum VARCHAR(100),
  class VARCHAR(100),
  family VARCHAR(100),
  taxon VARCHAR(200),
  block_number VARCHAR(10),
  total VARCHAR(20),
  diver VARCHAR(50),
  geom VARCHAR(100),
  PRIMARY KEY (fid)
);