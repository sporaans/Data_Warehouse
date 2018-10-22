--DatZ6054 : Datu noliktavu izvēlētas nodaļas
--1. praktiskais darbs
--Autors: Dāvis Sporāns DS16042

--Tabulu izveides skripti
CREATE TABLE D_LIETOTAJS 
   (dimension_key NUMBER(10) NOT NULL,
    ckods         NUMBER(10),
    tips_dzimums  VARCHAR2(10), 
    dzim_gads     NUMBER(10)
   );
   
ALTER TABLE D_LIETOTAJS ADD CONSTRAINT d_lietotajs_pk PRIMARY KEY (dimension_key);
   
CREATE TABLE D_PROGRAMMA 
   (dimension_key NUMBER(10) NOT NULL,
    pkods         VARCHAR2(5), 
    strukturv_stkods VARCHAR2(12), 
    pnosauk       VARCHAR2(400), 
    psaisin       VARCHAR2(8), 
    status        VARCHAR2(4)
   );
   
ALTER TABLE D_PROGRAMMA ADD CONSTRAINT d_programma_pk PRIMARY KEY (dimension_key);

CREATE TABLE D_STRUKT 
   (stkods        VARCHAR2(20),
    stnosauk      VARCHAR2(100));
   
CREATE TABLE D_LAIKS
   (datums_id     NUMBER(5),
    datums        DATE,
    menesis       NUMBER(5),
    gads          NUMBER(5)
   );
   
ALTER TABLE D_LAIKS ADD CONSTRAINT d_laiks_pk PRIMARY KEY (datums_id);
  
CREATE TABLE TF_FAKT
   (f_id_seq      NUMBER(10),
    fk_date_id    NUMBER(5),
    fk_prog_kods  VARCHAR2(5),
    fk_strukt     VARCHAR2(12),
    fk_user_id    NUMBER(10)
   );

CREATE TABLE FAKT AS 
(SELECT fk_date_id, fk_prog_kods, fk_strukt, fk_user_id FROM tf_fakt WHERE 1=2);

ALTER TABLE FAKT
ADD (hitu_skaits NUMBER(10),
     ex_date DATE);
     
--LOAD darbs

delete from fakt
where ex_date=trunc(sysdate);

insert into fakt 
(select fk_date_id, fk_prog_kods, fk_strukt, fk_user_id,skaits,trunc(sysdate) from
  (select fk_date_id,fk_strukt,fk_prog_kods,fk_user_id,skaits,
         rank() over (partition by fk_date_id,fk_strukt,fk_prog_kods order by skaits desc) skaits_rank
   from
   (select fk_date_id,fk_strukt, fk_prog_kods,  fk_user_id,count(f_id_seq) skaits
    from   tf_fakt
    group by fk_date_id,fk_strukt, fk_prog_kods, fk_user_id))
 where skaits_rank <=${st_skaits})
;
