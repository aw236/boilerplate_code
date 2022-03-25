# This file is a collection of convenience functions.
# A convenience function is a non-essential subroutine in a programming library or framework
# that is intended to ease commonly performed tasks.

# Table of Contents
# multiplot()                                       -- for plotting multiple ggplot objects
# pairs.panels(x, y, smooth = TRUE, scal e =FALSE)  -- for plotting pairs plots, or correlation matrices
# ggcorplot()                                       -- for plotting pairs plots, or correlation matrices

# Multiple plot function
# Credit to Winston Chang & his website: http://www.cookbook-r.com/
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
# example: multiplot(p1, p2, ..., pN, cols = 1)
# example: multiplot(p1, p2, ..., pN, layout = matrix(c(1,2,3,3), nrow=2, byrow=TRUE))
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  plots <- c(list(...), plotlist) # Make a list from the ... arguments and plotlist
  numPlots = length(plots)
  if (is.null(layout)) { # If layout is NULL, then use 'cols' to determine layout
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))}
  if (numPlots==1) {print(plots[[1]])} 
  else { 
    grid.newpage() # Set up the page
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))}}}

## Changes pairs() to plot correlation values on bottom left.
panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r = (cor(x, y,use="pairwise"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex )
}

## Check packages function.
## The following was written by Dr. Colin Rundel of Duke University.
##
# Example usage 1: (assumes you want to call from Github)
# library(devtools)    # Give source_url().
# suppressMessages(    # Load check_packages().
#   source_url("https://raw.githubusercontent.com/aw236/r.functions/master/functions.R")) 
#
# Example usage 2: (assumes "check_packages" is a function saved in a .R file called "check_packages.R"
# source("check_packages.R")                                                 # Load check_packages function.
# suppressMessages(check_packages(c('e1071','rgdal','raster',"devtools", ))) # Ensures listed packages are installed and load them. 
check_packages = function(names)
{
  for(name in names) {
    if (!(name %in% installed.packages()))
      install.packages(name, repos = "http://cran.us.r-project.org")
    library(name, character.only = TRUE)
  }
}

## Create pairs.panels() function. Use on dataframe of continuous variables.
## http://musicroamer.com/blog/2011/01/16/r-tips-and-tricks-modified-pairs-plot/
panel.cor.scale <- function(x, y, digits=2, prefix="", cex.cor) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r = (cor(x, y,use="pairwise"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex * abs(r))
}

panel.cor <- function(x, y, digits=2, prefix="", cex.cor) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r = (cor(x, y,use="pairwise"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex )
}

panel.hist <- function(x, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="cyan", ...)
}

pairs.panels <- function (x,y,smooth=TRUE,scale=FALSE) {
  if (smooth ){
    if (scale) {
      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale, lower.panel = panel.smooth)
    }
    else {
      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor, lower.panel = panel.smooth)
    } #else {pairs(x,diag.panel=panel.hist,upper.panel=panel.cor,lower.panel=panel.smooth)
  }
  else { #smooth is not true
    if (scale) {
      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor.scale)
    } 
    else {
      pairs(x, diag.panel = panel.hist, upper.panel = panel.cor) 
    }
  } #end of else (smooth)
} #end of function

## The following function is written by Winston Chang and was found at:
## http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
## Multiple plot function
## ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
## - cols:   Number of columns in layout
## - layout: A matrix specifying the layout. If present, 'cols' is ignored.
## If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
## then plot 1 will go in the upper left, 2 will go in the upper right, and
## 3 will go all the way across the bottom.
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

library(ggplot2)

#define a helper function (borrowed from the "ez" package)
ezLev=function(x,new_order){
	for(i in rev(new_order)){
		x=relevel(x,ref=i)
	}
	return(x)
}

ggcorplot = function(data, var_text_size, cor_text_limits){
	# normalize data
	for(i in 1:length(data)){
		data[,i]=(data[,i]-mean(data[,i]))/sd(data[,i])
	}
	# obtain new data frame
	z=data.frame()
	i = 1
	j = i
	while(i<=length(data)){
		if(j>length(data)){
			i=i+1
			j=i
		}else{
			x = data[,i]
			y = data[,j]
			temp=as.data.frame(cbind(x,y))
			temp=cbind(temp,names(data)[i],names(data)[j])
			z=rbind(z,temp)
			j=j+1
		}
	}
	names(z)=c('x','y','x_lab','y_lab')
	z$x_lab = ezLev(factor(z$x_lab),names(data))
	z$y_lab = ezLev(factor(z$y_lab),names(data))
	z=z[z$x_lab!=z$y_lab,]
	#obtain correlation values
	z_cor = data.frame()
	i = 1
	j = i
	while(i<=length(data)){
		if(j>length(data)){
			i=i+1
			j=i
		}else{
			x = data[,i]
			y = data[,j]
			x_mid = min(x)+diff(range(x))/2
			y_mid = min(y)+diff(range(y))/2
			this_cor = cor(x,y)
			this_cor.test = cor.test(x,y)
			this_col = ifelse(this_cor.test$p.value<.05,'<.05','>.05')
			this_size = (this_cor)^2
			cor_text = ifelse(
				this_cor>0
				,substr(format(c(this_cor,.123456789),digits=2)[1],2,4)
				,paste('-',substr(format(c(this_cor,.123456789),digits=2)[1],3,5),sep='')
			)
			b=as.data.frame(cor_text)
			b=cbind(b,x_mid,y_mid,this_col,this_size,names(data)[j],names(data)[i])
			z_cor=rbind(z_cor,b)
			j=j+1
		}
	}
	names(z_cor)=c('cor','x_mid','y_mid','p','rsq','x_lab','y_lab')
	z_cor$x_lab = ezLev(factor(z_cor$x_lab),names(data))
	z_cor$y_lab = ezLev(factor(z_cor$y_lab),names(data))
	diag = z_cor[z_cor$x_lab==z_cor$y_lab,]
	z_cor=z_cor[z_cor$x_lab!=z_cor$y_lab,]
	#start creating layers
	points_layer = layer(
		geom = 'point'
		, data = z
		, mapping = aes(
			x = x
			, y = y
		)
	)
	lm_line_layer = layer(
		geom = 'line'
		, geom_params = list(colour = 'red')
		, stat = 'smooth'
		, stat_params = list(method = 'lm')
		, data = z
		, mapping = aes(
			x = x
			, y = y
		)
	)
	lm_ribbon_layer = layer(
		geom = 'ribbon'
		, geom_params = list(fill = 'green', alpha = .5)
		, stat = 'smooth'
		, stat_params = list(method = 'lm')
		, data = z
		, mapping = aes(
			x = x
			, y = y
		)
	)
	cor_text = layer(
		geom = 'text'
		, data = z_cor
		, mapping = aes(
			x=y_mid
			, y=x_mid
			, label=cor
			, size = rsq
			, colour = p
		)
	)
	var_text = layer(
		geom = 'text'
		, geom_params = list(size=var_text_size)
		, data = diag
		, mapping = aes(
			x=y_mid
			, y=x_mid
			, label=x_lab
		)
	)
	f = facet_grid(y_lab~x_lab,scales='free')
	o = opts(
		panel.grid.minor = theme_blank()
		,panel.grid.major = theme_blank()
		,axis.ticks = theme_blank()
		,axis.text.y = theme_blank()
		,axis.text.x = theme_blank()
		,axis.title.y = theme_blank()
		,axis.title.x = theme_blank()
		,legend.position='none'
	)
	size_scale = scale_size(limits = c(0,1),to=cor_text_limits)
	return(
		ggplot()+
		points_layer+
		lm_ribbon_layer+
		lm_line_layer+
		var_text+
		cor_text+
		f+
		o+
		size_scale
	)
}

#set up some fake data
library(MASS)
N=100

#first pair of variables
variance1=1
variance2=2
mean1=10
mean2=20
rho = .8
Sigma=matrix(c(variance1,sqrt(variance1*variance2)*rho,sqrt(variance1*variance2)*rho,variance2),2,2)
pair1=mvrnorm(N,c(mean1,mean2),Sigma,empirical=T)

#second pair of variables
variance1=10
variance2=20
mean1=100
mean2=200
rho = -.4
Sigma=matrix(c(variance1,sqrt(variance1*variance2)*rho,sqrt(variance1*variance2)*rho,variance2),2,2)
pair2=mvrnorm(N,c(mean1,mean2),Sigma,empirical=T)

my_data=data.frame(cbind(pair1,pair2))

#ggcorplot(
#	data = my_data
#	, var_text_size = 30
#	, cor_text_limits = c(2,30)
#)
