ALTER TABLE E2E_DW_UAT.ADOPTION SET COMMENT = "Adoption tables contains project & experiment that are selected for further process";

create or replace view E2E_DW_UAT.CURRCNVRSN_VW(
	FROMCURRID,
	TOCURRID,
	EXCHANGERATE ,
	FROM_DT,
	TO_DT COMMENT 'CURRENCY CONVERSION RATE WITH NEW RATE'  
) as 
SELECT 
                 FROMCURRID
                ,TOCURRID
                ,EXCHANGERATE
                 , DATE AS FROM_DT
                ,NVL(LEAD(DATE-1,1) OVER(PARTITION BY FROMCURRID, TOCURRID ORDER BY DATE ),'9999-12-31')  AS TO_DT 
FROM ( SELECT FROMCURRID, TOCURRID,EXCHANGERATE,DATE
                                FROM CURRCNVRSN CURR
                                     ,CALENDAR CAL 
                                WHERE CURR.EXCHANGEEFFECTIVDATEID = CAL.DATEID
                                  AND EXCHANGERATETYPEID  = (SELECT CURREXCHANGERATETYPEID   FROM CURREXCHANGERATETYPE WHERE CURREXCHANGERATETYPE ='001S'
                                  )         );
