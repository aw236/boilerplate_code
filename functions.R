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
check_packages = function(names)
{
  for(name in names) {
    if (!(name %in% installed.packages()))
      install.packages(name, repos = "http://cran.us.r-project.org")
    library(name, character.only = TRUE)
  }
}