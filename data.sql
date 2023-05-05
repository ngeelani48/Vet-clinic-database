INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (1, 'Agumon', (to_date('03/02/2020','dd/mm/yyyy')), 0, true, 10.23),
(2, 'Gabumon', (to_date('15/11/2018','dd/mm/yyyy')), 2, true, 8.0), 
(3, 'Pikachu', (to_date('07/01/2021','dd/mm/yyyy')), 1,false,15.04), 
(4, 'Devimon', (to_date('12/05/2017','dd/mm/yyyy')), 5,true,11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (5, 'Charmander', (to_date('08/02/2020','dd/mm/yyyy')), 0, false, -11),
(6, 'Plantmon', (to_date('15/11/2021','dd/mm/yyyy')), 2, true, -5.7), 
(7, 'Squirtle', (to_date('02/04/1993','dd/mm/yyyy')), 3 , false, -12.13), 
(8, 'Angemon', (to_date('12/06/2005','dd/mm/yyyy')), 1, true, -45),
(9, 'Boarmon', (to_date('07/06/2005','dd/mm/yyyy')), 7, true, 20.4),
(10, 'Blossom', (to_date('13/10/1998','dd/mm/yyyy')), 3, true, 17),
(11, 'Ditto', (to_date('14/05/2022','dd/mm/yyyy')), 4, true, 22);

-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34), 
('Jennifer Orwell', 19), 
('Bob', 45), 
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

-- Modify animals so it includes the species_id value If the name ends in "mon" it will be Digimon All other animals are Pokemon
 
UPDATE animals SET species_id =
CASE WHEN name LIKE '%mon' then (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon') END;

-- Modify inserted animals to include owner information (owner_id)
UPDATE animals SET owner_id = CASE
WHEN name = 'Agumon' then (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name = 'Gabumon' OR name = 'Pikachu' then (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHEN name = 'Devimon' OR name = 'Plantmon' then (SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' then (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name = 'Boarmon' OR name = 'Angemon' then (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

-- Insert data into  vets table.
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08'); 

-- Insert data into the spesialization table.
INSERT INTO specializations (vet_id, species_id) VALUES
((select id from vets where name like 'William Tatcher'),
(select id from species where name = 'Pokemon')),
((select id from vets where name like 'Stephanie Mendez'),
(select id from species where name = 'Digimon')),
((select id from vets where name like 'Stephanie Mendez'),
(select id from species where name = 'Pokemon')),
((select id from vets where name like 'Jack Harkness'),
(select id from species where name = 'Digimon'));

-- Insert data into the visits table.
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES
  ((select id from animals where name like 'Agumon'),
    (select id from vets where name like 'William Tatcher'),
    '2020-05-24'),
  ((select id from animals where name like 'Agumon'),
    (select id from vets where name like 'Stephanie Mendez'),
    '2020-07-22'),
  ((select id from animals where name like 'Gabumon'),
    (select id from vets where name like 'Jack Harkness'),
    '2021-02-02'),
  ((select id from animals where name like 'Pikachu'),
    (select id from vets where name like 'Maisy  Smith'),
    '2020-01-05'),
  ((select id from animals where name like 'Pikachu'),
    (select id from vets where name like 'Maisy Smith'),
    '2020-03-08'),
  ((select id from animals where name like 'Pikachu'),
    (select id from vets where name like 'Maisy Smith'),
    '2020-05-14'),
  ((select id from animals where name like 'Davimon'),
    (select id from vets where name like 'Stephanie Mendez'),
    '2021-05-04'),
  ((select id from animals where name like 'Chamandar'),
    (select id from vets where name like 'Jack Harkness'),
    '2021-02-24'),
  ((select id from animals where name like 'Plantmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2019-12-21'),
  ((select id from animals where name like 'Plantmon'),
    (select id from vets where name like 'William Tatcher'),
    '2020-08-10'),
  ((select id from animals where name like 'Plantmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2021-04-07'),
  ((select id from animals where name like 'Squirtle'),
    (select id from vets where name like 'Stephanie Mendez'),
    '2019-09-29'),
  ((select id from animals where name like 'Angemon'),
    (select id from vets where name like 'Jack Harkness'),
    '2020-10-03'),
  ((select id from animals where name like 'Angemon'),
    (select id from vets where name like 'Jack Harkness'),
    '2020-11-04'),
  ((select id from animals where name like 'Boarmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2019-01-24'),
  ((select id from animals where name like 'Boarmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2019-05-15'),
  ((select id from animals where name like 'Boarmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2020-02-27'),
  ((select id from animals where name like 'Boarmon'),
    (select id from vets where name like 'Maisy Smith'),
    '2020-08-03'),
  ((select id from animals where name like 'Boarmon'),
    (select id from vets where name like 'Stephanie Mendez'),
    '2020-05-24'),
  ((select id from animals where name like 'Blossom'),
    (select id from vets where name like 'William Tatcher'),
    '2021-01-11');
