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



Insert the following data for specialties:
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon.
