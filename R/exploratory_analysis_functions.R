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
    geom_boxplot(outlier.size = 1.5, outlier.shape = 21, outlier.colour = "red") + 
    stat_summary(fun.y = "mean", geom = "point", shape = 23, size = 3, fill = "white") + 
    xlab("Instrução") + 
    ylab("Idade") + 
    theme_light()
}

educationLevelQQplot <- function(pns13){
  df <- ddply(.data = pns13, .variables = .(Instrucao), function(data){
    q <- qqnorm(data$Q003, plot = FALSE)
    data$xq <- q$x
    data
  })
  
  ggplot(df, aes(x = xq, y = Q003)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE, size = 0.7, colour = "red") + 
    facet_wrap(~ Instrucao) + 
    xlab("Teórico") + 
    ylab("Amostra") + 
    theme_light()
}