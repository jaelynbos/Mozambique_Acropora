library(cowplot)
library(ggmap)
library(sf)
library(ggspatial)
library(tidyverse)

setwd("C:/Users/jaely/Documents/Mozambique_Adivaricata")
sites<-read.csv("metadat_with_admix.csv")

caldeira_points<-sites[sites$Latitude<(-15),]
pemba_points<-sites[sites$Latitude>(-15),]

pemba_loggers<-data.frame(lat=c(-12.915556,-12.925,-12.96),lon=c(40.499167,40.51361,40.558889))

caldeira_loggers<-data.frame(lat=-16.641389,lon=39.7225)

ggmap::register_google("NotGoingToPushMyAPIKey_ThisTime",write=TRUE)
mozambig<-get_googlemap(center=c(lon=40.5,lat=-16),zoom=7,maptype="terrain",style = c("feature:all|element:labels|visibility:off"))

pemba<-get_googlemap(center=c(lon=40.51,lat=-12.93),zoom=12,maptype="satellite",style = c('feature:all|element:labels|visibility:off'))
caldeira<-get_googlemap(center=c(lon=39.725,lat=-16.65),zoom=14,maptype="satellite",style = c('feature:all|element:labels|visibility:off'))


ggmap(caldeira) + 
  coord_sf(
    crs = 4326,
    xlim = c(39.705,39.755), 
    ylim = c(-16.66,-16.63), 
    expand = FALSE
  ) + 
  geom_point(data=caldeira_points,aes(x=Longitude,y=Latitude),cex=8,color='darkorange',alpha=0.5,position="jitter")+
annotation_scale(location = "bl", width_hint = 0.4,height= unit(0.5, "cm"),unit_category = "metric",text_cex = 1.5,text_col="white")+
  geom_point(data = caldeira_loggers, aes(x = lon, y = lat), color ="white",size = 8,shape=17)+
theme(
  axis.title = element_blank(), 
  axis.text = element_blank(),   
  axis.ticks = element_blank()   
)
ggsave("caldeira_map.png", width = 8, height = 8, dpi = 800)


ggmap(pemba) + 
  coord_sf(
    crs = 4326,
    xlim = c(40.45,40.6), 
    ylim = c(-13,-12.88), 
    expand = FALSE
  ) + 
  geom_point(data=pemba_points,aes(x=Longitude,y=Latitude),cex=7,color='darkorange',alpha=0.5,position="jitter")+
  geom_point(data = pemba_loggers, aes(x = lon, y = lat), color ="white", size = 8,shape=17)+
  annotation_scale(location = "bl", width_hint = 0.4,height= unit(0.5, "cm"),unit_category = "metric",text_cex = 1.5,text_col="white")+
  geom_rect(
    aes(xmin = 40.49, xmax = 40.505, ymin = -12.92, ymax = -12.90),
    color = "darkorange", fill = NA, linewidth = 2.5)+
    
  theme(
    axis.title = element_blank(), 
    axis.text = element_blank(),   
    axis.ticks = element_blank()   
  )
ggsave("pemba_map.png", width = 8, height = 8, dpi = 800)

moz_all<-ggmap(mozambig)+
  coord_sf(
    crs = 4326,
    xlim = c(38,42), 
    ylim = c(-17.5,-12.5), 
    expand = FALSE
  ) + 
  xlab('Latitude') +
  ylab('Longitude') +
  geom_rect(
    aes(xmin = 40.4, xmax = 40.6, ymin = -13, ymax = -12.88),
    color = "darkorange", fill = NA, linewidth = 1.5
  )+
  geom_rect(
    aes(xmin = 39.70, xmax = 39.755, ymin = -16.66, ymax = -16.6),
    color = "darkorange", fill = NA, linewidth = 1.5
  )+
  annotation_scale(location = "bl", width_hint = 0.4,height= unit(0.5, "cm"),unit_category = "metric",text_cex = 1.5,text_col="black")+
  theme(
    axis.title.x = element_text(size = 16), 
    axis.title.y = element_text(size = 16),
    axis.text.x = element_text(size = 12),  
    axis.text.y = element_text(size = 12)   
  )
ggsave("moz_overview.png", width = 8, height = 10, dpi = 800)
  