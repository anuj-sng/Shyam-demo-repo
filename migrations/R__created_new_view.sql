create or replace view E2E_DEV_PILOT_DB.E2E_BI.VWPRODUCINGPLANT_OLD(
	MATERIALSUPERTYPEID,
	PLANTID_ORIGINAL,
	PLANTID_FINAL COMMENT 'THIS IS THE FINAL PLANT ID R11234'
) as
SELECT PM.MATERIALSUPERTYPEID, PM.PLANTID AS PLANTID_ORIGINAL, 
CASE MATERIALSUPPLYSOURCECODE 
WHEN 'E' THEN PM.PLANTID 
ELSE PS.PURCHASINGORGANIZATNID 
END PLANTID_FINAL
FROM PLANTMATERIALDETAIL PM 
LEFT JOIN MATERIALSUPPLYSOURCE MSS ON PM.MATERIALSUPPLYSOURCEID = MSS.MATERIALSUPPLYSOURCEID
LEFT JOIN PURCHASINGSOURCELISTDETAIL PS ON PM.PLANTID= PS.PLANTID AND PM.MATERIALSUPERTYPEID = PS.MATERIALSUPERTYPEID AND ISPREFERREDVENDOR = 1;

 
