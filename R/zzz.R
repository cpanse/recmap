#R

.onAttach <- function(lib, pkg){
	if(interactive()){
		version <- packageVersion('recmap')
		packageStartupMessage("Package 'recmap' version ", version)
		# packageStartupMessage("Type 'citation(\"recmap\")' for citing this R package in publications.")
	  invisible()
	}
}
