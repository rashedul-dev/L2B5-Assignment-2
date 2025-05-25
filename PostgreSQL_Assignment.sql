CREATE Table rangers(
    ranger_id INT PRIMARY KEY,
    name varchar(25) NOT NULL,
    region VARCHAR(50)
);
CREATE Table species(
    species_id INT PRIMARY KEY,
    common_name VARCHAR(25), 
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)  
);
CREATE Table sightings(
    sighting_id INT PRIMARY KEY ,
    species_id INT  REFERENCES species (species_id), 
    ranger_id INT REFERENCES rangers (ranger_id) ,
    location VARCHAR(25) ,
    sighting_time TIMESTAMP WITHOUT TIME ZONE ,
    notes TEXT           
);

INSERT into rangers(ranger_id,name,region)
VALUES(1,'Alice Green','Northern Hills'),
      (2,'Bob White','River Delta'),
      (3,'Carol King','Mountain Range');



INSERT into species(species_id,common_name,scientific_name,discovery_date,conservation_status)
VALUES(1,'Snow Leopard','Panthera uncia','1775-01-01','Endangered'),
      (2,'Bengal Tiger','Panthera tigris tigris','1758-01-01','Endangered'),
      (3,'Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),
      (4,'Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');

INSERT INTO sightings(sighting_id,species_id,ranger_id,location,sighting_time,notes)
VALUES(1,1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
      (2,2,2,'Bankwood_Area','2024-05-12 16:20:00','Juvenile seen'),
      (3,3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
      (4,1,2,'Snowfall Pass','2024-05-18 18:30:00',NULL);


-- SHOWING ALL THE TABLES 
SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;


-- PROBLEM 01
INSERT into rangers(ranger_id,name,region)
VALUES(4,'Derek Fox','Coastal Plains');

-- PROBLEM 02
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings; 

--PROBLEM 03

SELECT * from sightings
where location LIKE '%Pass%';

--PROBLEM 04

SELECT name, count(*) AS total_sightings 
from rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY name
ORDER BY NAME ASC;


--PROBLEM 05
SELECT common_name
from species
LEFT JOIN sightings ON species.species_id = sightings.species_id
where sighting_id IS NULL;

--PROBLEM 06