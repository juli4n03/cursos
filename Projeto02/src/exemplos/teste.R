rm(list = ls(all.names = TRUE))


library(arrow)
library(here)
library(glue)

# Define o diretório onde os arquivos estão localizados
# dir_applprev   = here("C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train")
# dir_bureau_a_1 = here("/Projeto02/data/train/train_credit_bureau_a_1")
# dir_bureau_a_2 = here("/Projeto02/data/train/train_credit_bureau_a_2")
dir_static     = c(
  here(here(), "Projeto02/data/train/train_static_0_0.parquet"),
  here(here(), "Projeto02/data/train/train_static_0_1.parquet"),
  here(here(), "Projeto02/data/train/train_static_cb_0.parquet")
)
dir_base = here(here(), "Projeto02/data/train/train_base.parquet")
dir_other = here(here(), "Projeto02/data/train/train_other_1.parquet")



# train_applprev = open_dataset(dir_applprev, format = "parquet")
# train_credit_bureau_a_1 = open_dataset(dir_bureau_a_1, format = "parquet")
# train_credit_bureau_a_2 = open_dataset(dir_bureau_a_2, format = "parquet")
train_static = open_dataset(dir_static, format = "parquet")
# train_applprev_2 = open_dataset(paste0(dir_train,"/train_applprev_2.parquet"), format = "parquet")
train_base = open_dataset(dir_base, format = "parquet")
# train_credit_bureau_b_1 = open_dataset(paste0(dir_train,"/train_credit_bureau_b_1.parquet"), format = "parquet")
# train_credit_bureau_b_2 = open_dataset(paste0(dir_train,"/train_credit_bureau_b_2.parquet"), format = "parquet")
# train_debitcard_1 = open_dataset(paste0(dir_train,"/train_debitcard_1.parquet"), format = "parquet")
# train_deposit_1 = open_dataset(paste0(dir_train,"/train_deposit_1.parquet"), format = "parquet")
train_other_1 = open_dataset(dir_other, format = "parquet")
# train_person_1 = open_dataset(paste0(dir_train,"/train_person_1.parquet"), format = "parquet")
# train_person_2 = open_dataset(paste0(dir_train,"/train_person_2.parquet"), format = "parquet")
# train_static_cb_0 = open_dataset(paste0(dir_static,"/train_static_cb_0.parquet"), format = "parquet")
# train_tax_registry_a_1 = open_dataset(paste0(dir_train,"/train_tax_registry_a_1.parquet"), format = "parquet")
# train_tax_registry_b_1 = open_dataset(paste0(dir_train,"/train_tax_registry_b_1.parquet"), format = "parquet")
# train_tax_registry_c_1 = open_dataset(paste0(dir_train,"/train_tax_registry_c_1.parquet"), format = "parquet")

joined_data <- train_base %>% 
  left_join(train_static, by = "case_id") %>%
    left_join(train_other_1, by = "case_id")  
  # left_join(train_static_cb_0, by = "case_id")


resultado <- tryCatch({
  res <- joined_data %>% 
    select(date_decision
          ,datefirstoffer_1144D
         ,datelastinstal40dpd_247D
         ,datelastunpaid_3546854D
         ,dtlastpmtallstes_4499206D
         ,firstclxcampaign_1125D 
         ,firstdatedue_489D
         ,lastactivateddate_801D
         ,lastapplicationdate_877D
         ,lastapprdate_640D
         ,lastdelinqdate_224D
         ,lastrejectdate_50D
         ,lastrepayingdate_696D
         ,maxdpdinstldate_3546855D
         ,payvacationpostpone_4187118D
         ,validfrom_1069D
  ) %>%
  mutate(
    flag_datefirstoffer_1144D = if_else(
      is.na(datefirstoffer_1144D), 0,
      1
    ),
    dif_datefirstoffer_1144D = if_else(
      flag_datefirstoffer_1144D == 0, 0,
      as.numeric(as.integer(date_decision)-as.integer(datefirstoffer_1144D))
    )
  )
  res %>% head %>% compute %>% View()

}, error = function(err) {
  # error handler picks up where error was generated
  print(glue("MY_ERROR: {err} "))
})



            # ,flag_datelastinstal40dpd_247D = if_else(is.na(datelastinstal40dpd_247D),0,1) 
            # ,flag_datelastunpaid_3546854D = if_else(is.na(datelastunpaid_3546854D),0,1) 
            # ,flag_dtlastpmtallstes_4499206D = if_else(is.na(dtlastpmtallstes_4499206D),0,1) 
            # ,flag_firstclxcampaign_1125D = if_else(is.na(firstclxcampaign_1125D),0,1) 
            # ,flag_firstdatedue_489D = if_else(is.na(firstdatedue_489D),0,1) 
            # ,flag_lastactivateddate_801D = if_else(is.na(lastactivateddate_801D),0,1) 
            # ,flag_lastapplicationdate_877D = if_else(is.na(lastapplicationdate_877D),0,1) 
            # ,flag_lastapprdate_640D = if_else(is.na(lastapprdate_640D),0,1) 
            # ,flag_lastdelinqdate_224D = if_else(is.na(lastdelinqdate_224D),0,1) 
            # ,flag_lastrejectdate_50D = if_else(is.na(lastrejectdate_50D),0,1) 
            # ,flag_lastrepayingdate_696D = if_else(is.na(lastrepayingdate_696D),0,1) 
            # ,flag_maxdpdinstldate_3546855D = if_else(is.na(maxdpdinstldate_3546855D),0,1) 
            # ,flag_payvacationpostpone_4187118D = if_else(is.na(payvacationpostpone_4187118D),0,1) 
            # ,flag_validfrom_1069D = if_else(is.na(validfrom_1069D),0,1)
            # ,dif_datelastinstal40dpd_247D = if_else(is.na(datelastinstal40dpd_247D),"",as.character(as.Date(date_decision)-as.Date(datelastinstal40dpd_247D)))
            # ,dif_datelastunpaid_3546854D = if_else(is.na(datelastunpaid_3546854D),"",as.character(as.Date(date_decision)-as.Date(datelastunpaid_3546854D)))
            # ,dif_dtlastpmtallstes_4499206D = if_else(is.na(dtlastpmtallstes_4499206D),"",as.character(as.Date(date_decision)-as.Date(dtlastpmtallstes_4499206D)))
            # ,dif_firstclxcampaign_1125D = if_else(is.na(firstclxcampaign_1125D),"",as.character(as.Date(date_decision)-as.Date(firstclxcampaign_1125D)))
            # ,dif_firstdatedue_489D = if_else(is.na(firstdatedue_489D),"",as.character(as.Date(date_decision)-as.Date(firstdatedue_489D)))
            # ,dif_lastactivateddate_801D = if_else(is.na(lastactivateddate_801D),"",as.character(as.Date(date_decision)-as.Date(lastactivateddate_801D)))
            # ,dif_lastapplicationdate_877D = if_else(is.na(lastapplicationdate_877D),"",as.character(as.Date(date_decision)-as.Date(lastapplicationdate_877D)))
            # ,dif_lastapprdate_640D = if_else(is.na(lastapprdate_640D),"",as.character(as.Date(date_decision)-as.Date(lastapprdate_640D)))
            # ,dif_lastdelinqdate_224D = if_else(is.na(lastdelinqdate_224D),"",as.character(as.Date(date_decision)-as.Date(lastdelinqdate_224D)))
            # ,dif_lastrejectdate_50D = if_else(is.na(lastrejectdate_50D),"",as.character(as.Date(date_decision)-as.Date(lastrejectdate_50D)))
            # ,dif_lastrepayingdate_696D = if_else(is.na(lastrepayingdate_696D),"",as.character(as.Date(date_decision)-as.Date(lastrepayingdate_696D)))
            # ,dif_maxdpdinstldate_3546855D = if_else(is.na(maxdpdinstldate_3546855D),"",as.character(as.Date(date_decision)-as.Date(maxdpdinstldate_3546855D)))
            # ,dif_payvacationpostpone_4187118D = if_else(is.na(payvacationpostpone_4187118D),"",as.character(as.Date(date_decision)-as.Date(payvacationpostpone_4187118D)))
            # ,dif_validfrom_1069D = if_else(is.na(validfrom_1069D),"",as.character(as.Date(date_decision)-as.Date(validfrom_1069D)))) %>% 
        # mutate(dif_datefirstoffer_1144D = as.numeric(dif_datefirstoffer_1144D))
            # ,dif_datelastinstal40dpd_247D = as.numeric(dif_datelastinstal40dpd_247D)
            # ,dif_datelastunpaid_3546854D = as.numeric(dif_datelastunpaid_3546854D)
            # ,dif_dtlastpmtallstes_4499206D = as.numeric(dif_dtlastpmtallstes_4499206D)
            # ,dif_firstclxcampaign_1125D = as.numeric(dif_firstclxcampaign_1125D)
            # ,dif_firstdatedue_489D = as.numeric(dif_firstdatedue_489D)
            # ,dif_lastactivateddate_801D = as.numeric(dif_lastactivateddate_801D)
            # ,dif_lastapplicationdate_877D = as.numeric(dif_lastapplicationdate_877D)
            # ,dif_lastapprdate_640D = as.numeric(dif_lastapprdate_640D)
            # ,dif_lastdelinqdate_224D = as.numeric(dif_lastdelinqdate_224D)
            # ,dif_lastrejectdate_50D = as.numeric(dif_lastrejectdate_50D)
            # ,dif_lastrepayingdate_696D = as.numeric(dif_lastrepayingdate_696D)
            # ,dif_maxdpdinstldate_3546855D = as.numeric(dif_maxdpdinstldate_3546855D)
            # ,dif_payvacationpostpone_4187118D = as.numeric(dif_payvacationpostpone_4187118D)
            # ,dif_validfrom_1069D = as.numeric(dif_validfrom_1069D)) %>% 
  # select(-c("datefirstoffer_1144D"
  #        ,"datelastinstal40dpd_247D"
  #        ,"datelastunpaid_3546854D"
  #        ,"dtlastpmtallstes_4499206D"
  #        ,"firstclxcampaign_1125D"
  #        ,"firstdatedue_489D"
  #        ,"lastactivateddate_801D"
  #        ,"lastapplicationdate_877D"
  #        ,"lastapprdate_640D"
  #        ,"lastdelinqdate_224D"
  #        ,"lastrejectdate_50D"
  #        ,"lastrepayingdate_696D"
  #        ,"maxdpdinstldate_3546855D"
  #        ,"payvacationpostpone_4187118D"
  #        ,"validfrom_1069D")) %>% 
   
  

