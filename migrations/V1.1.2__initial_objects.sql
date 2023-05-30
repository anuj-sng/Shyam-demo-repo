ALTER TABLE ADOPTION SET COMMENT = "Adoption table contains project & experiment that are selected for further process";-- COMMENTS IN TABLE

create or replace view CURRCNVRSN_VW(
      FROMCURRID,
      TOCURRID,
      EXCHANGERATE ,
      FROM_DT,
      TO_DT COMMENT 'CURRENCY CONVERSION RATE NEW POC'  
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
                                  AND EXCHANGERATETYPEID  = (SELECT CURREXCHANGERATETYPEID
                                                                                FROM CURREXCHANGERATETYPE 
                                                                                 WHERE CURREXCHANGERATETYPE ='001S'
                                                                                )
                );
