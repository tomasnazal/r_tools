#Graphs theme
my_theme <- ggplot2::theme(panel.grid = ggplot2::element_blank(),
                  panel.background = ggplot2::element_blank(),
                  plot.title = ggplot2::element_text(hjust = 0.5),
                  strip.background = ggplot2::element_blank(),
                  legend.key = ggplot2::element_blank())
##0-1 normalization
normalize_scalar1 <- function(x, na.rm = T)
{x / sqrt(sum(x^2, na.rm = na.rm))}

#not in
"%!in%" <- function(x,y){!('%in%'(x,y))}

##Financial Year
fy <- function(vector){
  ifelse(vector >
           as.Date(paste(lubridate::year(vector),
                         "06","30", sep = "-")),
         year(vector + 365),
         year(vector))
}
