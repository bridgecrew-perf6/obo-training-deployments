DROP VIEW IF EXISTS vw_obo_professional_info;
CREATE VIEW vw_obo_professional_info  AS		
SELECT 
    pi.*,
    CONCAT( pi.lastname, ', ', pi.firstname, ' ', SUBSTRING( pi.middlename, 0, 1 ), '.' ) AS name, 
	id.caption AS id_type_caption,
	id.title AS id_type_title

FROM obo_professional_info pi  
LEFT JOIN idtype id ON pi.id_type_name = id.name;	
