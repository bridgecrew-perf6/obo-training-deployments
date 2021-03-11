DROP VIEW IF EXISTS vw_obo_professional_info_lookup;
CREATE VIEW vw_obo_professional_info_lookup  AS		
SELECT 
    pi.*,
    CONCAT( pi.lastname, ', ', pi.firstname, ' ', SUBSTRING( pi.middlename, 0, 1 ), '.' ) AS name, 
	id.caption AS id_type_caption,
	id.title AS id_type_title
FROM obo_professional_info pi  
INNER JOIN obo_professional p ON p.infoid = pi.objid 
LEFT JOIN idtype id ON pi.id_type_name = id.name
UNION ALL 
SELECT 
    pi.*,
    CONCAT( pi.lastname, ', ', pi.firstname, ' ', SUBSTRING( pi.middlename, 0, 1 ), '.' ) AS name, 
	id.caption AS id_type_caption,
	id.title AS id_type_title
FROM obo_professional_info pi  
LEFT JOIN idtype id ON pi.id_type_name = id.name
WHERE pi.prc_idno NOT IN ( SELECT prcno FROM obo_professional )


