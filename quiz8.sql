CREATE TABLE apple_org_structure 
(
   employee_name character(100) NOT NULL, 
   title character(100) NOT NULL,
   reports_to character(100)
) 
;
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
SELECT * FROM apple_org_structure;

DELETE FROM apple_org_structure
WHERE employee_name='steve jobs';

UPDATE apple_org_structure
SET title='ceo',reports_to = '' 
WHERE employee_name='tim cook';

UPDATE apple_org_structure
SET reports_to='susan wojcicki'
WHERE reports_to='tim cook';

UPDATE apple_org_structure
SET reports_to='tim cook'
WHERE reports_to='steve jobs';

INSERT INTO apple_org_structure 
VALUES ('susan wojcicki','chief operating officeer','tim cook');


