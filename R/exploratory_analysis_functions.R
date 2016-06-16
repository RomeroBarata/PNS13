educationLevelHistogram <- function(pns13){
  ggplot(pns13, aes(x = Q003)) + 
    geom_histogram(aes(y = ..density..), colour = "black", fill = "white") + 
    facet_wrap(~ Instrucao) + 
    xlab("Idade") + 
    ylab("Densidade") + 
    theme_light()
}

educationLevelBoxplot <- function(pns13){
  ggplot(pns13, aes(x = Instrucao, y = Q003)) + 
    geom_boxplot(outlier.size = 1.5, outlier.shape = 21) + 
    stat_summary(fun.y = "mean", geom = "point", shape = 23, size = 3, fill = "white") + 
    xlab("Instrução") + 
    ylab("Idade") + 
    theme_light()
}