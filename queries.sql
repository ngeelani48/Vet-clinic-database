SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- query and update animals table
-- 1
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- 2
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE TRIM(species) IS NULL;
COMMIT;
SELECT * FROM animals;
-- 3
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- 4
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT bfr_update_wt;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO bfr_update_wt;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- queries to answer the  questions

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered,SUM(escape_attempts) AS SUM FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- queries (using JOIN) to answer the questions:

-- 1.What animals belong to Melody Pond?
SELECT name 
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

--2.List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, animals.species_id, animals.owner_id, species.name as species_type FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--3. List all owners and their animals, remember to include those that don't own any animal.
SELECT name AS animal_name, full_name AS owners FROM animals
RIGHT JOIN owners ON owners.id = animals.owner_id;

--4. How many animals are there per species?
SELECT species.name, COUNT(animals.name)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--5. List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name FROM animals
JOIN species ON species.id = animals.species_id AND species.name = 'Digimon'
JOIN owners ON owners.id = animals.owner_id AND owners.full_name = 'Jennifer Orwell';

--6. List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name, full_name as owner_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS count FROM animals
JOIN owners ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;

