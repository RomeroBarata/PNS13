preProcessPNS13 <- function(pns13){
  # Filter by arterial hypertension
  pns13 <- pns13 %>% filter(Q002 == 1)
  
  # Age >= 18
  pns13$Q003 <- as.integer(pns13$Q003)
  pns13 <- pns13 %>% filter(Q003 >= 18)
  
  # Create a new column named 'Instrucao'
  pns13 <- pns13 %>% mutate(Instrucao = plyr::mapvalues(pns13$VDD004, 
                                                        c(1, 2, 3, 4, 5, 6, 7), 
                                                        c("Sem Instrução", "Sem Instrução", 
                                                          "Fundamental", "Fundamental", 
                                                          "Médio", "Médio", "Superior")))
  pns13$Instrucao <- factor(pns13$Instrucao, levels = c("Sem Instrução", "Fundamental", 
                                                        "Médio", "Superior"))
  
  pns13
}