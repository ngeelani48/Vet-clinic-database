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

-- Queries about Vet clinic database: add "join table" for visits(day 4)

-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS animal_name, visits.date_of_visit, vets.name AS vet_name
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) AS checked_animals
FROM animals 
JOIN visits ON visits.animal_id = animals.id 
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name , species.name AS species FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name, visits.date_of_visit FROM animals 
JOIN visits  ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.date_of_visit) AS number_of_visits
FROM animals JOIN visits ON visits.animal_id = animals.id 
GROUP BY animals.name 
ORDER BY number_of_visits 
DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal_name, visits.date_of_visit
FROM animals 
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name As animal_name, animals.weight_kg, animals.date_of_birth,
animals.neutered,vets.name AS vet_name, vets.date_of_graduation,
visits.date_of_visit FROM animals 
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id) AS total_unspecialized_visits FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON specializations.species_id = vets.id
WHERE specializations.species_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS specialty_required, COUNT(visits.animal_id)
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT DESC LIMIT 1; 



