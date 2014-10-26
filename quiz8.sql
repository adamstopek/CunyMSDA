--Deliverable 1) The script to create the table
CREATE TABLE apple_org_structure 
(
   employee_name character(100) NOT NULL, 
   title character(100) NOT NULL,
   reports_to character(100)
) 
;
--Deliverable 2) The INSERT statements to populate the table
INSERT INTO apple_org_structure 
VALUES
('steve jobs','ceo',''),
('scott forstall','svp of ios software','steve jobs'),
('peter oppenheimer','svp chief financial officer','steve jobs'),
('isabel ge mahe','vp ios wireless software','scott forstall'),
('henri lamiraux','vp engineering ios apps','scott forstall'),
('kim vorrath','vp program management','scott forstall'),
('betsy rafael','vp controller','peter oppenheimer'),
('gary wipfler','vp treasurer','peter oppenheimer')
;
-- Deliverable 3) The SQL query to pull all the information from the table
SELECT * FROM apple_org_structure;

-- Deliverable 4) The [INSERT, UPDATE, DELETE] SQL statements needed to update the information to reflect:
--(a) Tim Cook replaces Steve Jobs as CEO, and 
--(b) Apple (hypothetically) hires Susan Wojcicki away from Google to replace Tim Cook at COO, with the COO reports unchanged.

--Steve Dies
DELETE FROM apple_org_structure
WHERE employee_name='steve jobs';

--Tim gets promoted, no longer reports to anyone and title changes
UPDATE apple_org_structure
SET title='ceo',reports_to = '' 
WHERE employee_name='tim cook';

--All people who reported to Tim now report to Susan
UPDATE apple_org_structure
SET reports_to='susan wojcicki'
WHERE reports_to='tim cook';

-- All people who reported to Steve now report to Tim
UPDATE apple_org_structure
SET reports_to='tim cook'
WHERE reports_to='steve jobs';

--Susan gets hired
INSERT INTO apple_org_structure 
VALUES ('susan wojcicki','chief operating officeer','tim cook');
