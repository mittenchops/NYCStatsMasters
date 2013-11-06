# Data Source
# http://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/climate-normals/1981-2010-normals-data
# http://gis.ncdc.noaa.gov/map/viewer/#app=cdo&cfg=cdo&theme=normals&layers=01&node=gis&extent=-149.3:20.2:-60.1:69.6&custom=normals

nyc <- c(33.4,33.3,33.1,33,32.9,32.8,32.7,32.6,32.5,32.4,32.4,32.3,32.3,32.3,32.3,32.2,32.2,32.3,32.3,32.3,32.3,32.4,32.4,32.5,32.5,32.6,32.7,32.8,32.9,33,33.1) # central park in january
chi <- c(24.4,24.3,24.2,24.1,24,23.9,23.9,23.8,23.7,23.7,23.6,23.6,23.5,23.5,23.5,23.5,23.4,23.4,23.4,23.4,23.5,23.5,23.5,23.6,23.6,23.7,23.8,23.9,24,24.1,24.2) # chicago in january

t.test(nyc,chi,paired=T)
#	Paired t-test
#data:  nyc and chi 
#t = 644.8545, df = 30, p-value < 2.2e-16
#alternative hypothesis: true difference in means is not equal to 0 
#95 percent confidence interval:
# 8.830011 8.886118 
#sample estimates:
#mean of the differences 
#               8.858065 

nyc <- c(75.3,75.5,75.6,75.8,75.9,76,76.1,76.2,76.3,76.4,76.5,76.6,76.6,76.7,76.7,76.7,76.8,76.8,76.8,76.8,76.8,76.8,76.8,76.8,76.8,76.7,76.7,76.7,76.7,76.6,76.6)
chi <- c(73.2,73.3,73.5,73.6,73.7,73.8,73.9,74,74.1,74.2,74.2,74.3,74.3,74.3,74.3,74.3,74.3,74.3,74.3,74.2,74.2,74.2,74.1,74.1,74,74,73.9,73.9,73.8,73.8,73.7)

t.test(nyc, chi,paired=T)
#	Paired t-test
#
#data:  nyc and chi 
#t = 53.4294, df = 30, p-value < 2.2e-16
#alternative hypothesis: true difference in means is not equal to 0 
#95 percent confidence interval:
# 2.367211 2.555370 
#sample estimates:
#mean of the differences 
#                2.46129 

