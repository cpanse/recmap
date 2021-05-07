#R

.onAttach <- function(lib, pkg){
	if(interactive()){
		version <- packageVersion('recmap')
		packageStartupMessage("Package 'recmap' version ", version)
	  invisible()
	}
}
