#R


.get_county_mbb <- function(state='colorado', scaleX = 0.5, scaleY = 0.5){
  MBB <- lapply(map('county', state, plot = FALSE)$names,
                function(x){
                  r <- map('county', x, plot = FALSE)
                  dx <- scaleX * (r$range[2] - r$range[1])
                  dy <- scaleY * (r$range[4] - r$range[3])
                  x <- r$range[1] + dx
                  y <- r$range[3] + dy
                  data.frame(polyname=r$name, x=x, y=y, dx=dx, dy=dy)
                }
  )
  MBB <- do.call('rbind', MBB)
  MBB <- merge(MBB, county.fips, by='polyname')
  MBB$fips <- as.integer(MBB$fips)
  
  P <- data.frame(fips = paste(counties$state_fips,
                               counties$county_fips, sep=''),
                  z = counties$population,      
                  name = counties$county_name)
  P$fips <- as.integer(levels(P$fips))[P$fips]
  
  M <- merge(MBB, P, by='fips')
  class(M) <- c('recmap', 'data.frame')
  M
}