# R-Ladies ggplot2 theme
# main purple color: #88398A
# grey color: #D3D3D3
# black color: #181818
# white color: #FFFFFF
# dark purple color: #562457
# font Helvetica Neue

r_ladies_theme <- function(){
  theme_bw() %+replace% 
    theme(text = element_text(family = "HelveticaNeue", face = "plain",
                              colour = 'black', size = 10,
                              hjust = .5, vjust = .5, angle = 0, 
                              lineheight = 1.1, 
                              margin = margin(t = 0, r = 0, b = 0, l = 0, 
                                              unit = "pt"), 
                              debug= FALSE), 
          axis.text = element_text(colour = "#181818"), 
          axis.title = element_text(face = "bold", colour = "#88398A", size = rel(1.1)), 
          plot.title = element_text(face = "bold", size = rel(1.4), 
                                    colour = "#88398A", 
                                    margin = margin(t = 0, r = 0, b = 6.6,
                                                    l = 0, unit = "pt")),
          legend.title = element_text(face = "bold", colour = "#181818"),
          panel.grid.major = element_line(color = "#D3D3D3"))
}
  