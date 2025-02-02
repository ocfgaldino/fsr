% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fsi_functions.R
\name{fsi_eval}
\alias{fsi_eval}
\title{Evaluating an FSI model for a given point location}
\usage{
fsi_eval(fsi, point, ...)
}
\arguments{
\item{fsi}{An FSI model built with the function \code{fsi_create} and populated by the functions \code{fsi_add_fsa}, \code{fsi_add_cs}, and \code{fsi_add_rules}.}

\item{point}{An \code{sfg} object of geometry type \code{point}, which is created through the function \code{st_point} of the sf package.}

\item{...}{<\code{\link[rlang:dyn-dots]{dynamic-dots}}> Informs the \code{fsi_eval} how the elements of the resulting fuzzy set should be discretized if the user does not want the default configuration (see below). Default values: \code{discret_by} is 0.5 and \code{discret_length} is NULL.}
}
\value{
A numeric value that belongs to the domain of the consequent (i.e., as specified by \code{fsi_add_cs}) and represents the result of the reasoning process in a particular point location.
}
\description{
This function executes the reasoning process of a fuzzy spatial inference (FSI) model
for a given point location (i.e., \code{sfg} object of the type \code{POINT}).
}
\details{
This function evaluates an FSI model populated with its fuzzy spatial antecedent, consequent, and fuzzy rules set on a specific point location. This evaluation is based on the algorithm specified by \href{https://ieeexplore.ieee.org/document/8015707}{FIFUS}.

The default behavior of the function \code{fsi_eval} in the parameter \code{...} is to consider a discrete interval of values with an increment of 0.5 between lower and upper values for the consequent domain (i.e., defined at \code{fsi_add_cs} function with the parameter \code{bounds}).

The user can modify the default behavior by using one of the following two ways:
\itemize{
\item define a value for the parameter \code{discret_by} by changing the incremental value.
\item define a desired length for the sequence of values domain of the consequent \code{discret_length}.
}
}
\examples{

library(sf)
# Creating the FSI model from an example implemented with the visitation function:
fsi <- visitation()

# Creating a vector of fuzzy rules; 
## note that we make use of the linguistic variables and linguistic values previously defined:
rules <- c(
  "IF accommodation review is reasonable AND food safety is low 
  THEN visiting experience is awful",
 "IF accommodation price is expensive AND accommodation review is reasonable 
   THEN visiting experience is awful",
 "IF accommodation price is affordable AND accommodation review is good AND food safety is medium 
   THEN visiting experience is average",
 "IF accommodation price is affordable AND accommodation review is excellent 
                                                                AND food safety is high 
   THEN visiting experience is great",
 "IF accommodation price is cut-rate AND accommodation review is excellent AND food safety is high 
   THEN visiting experience is great")

# Adding these rules to the FSI model previously instantiated:
fsi <- fsi_add_rules(fsi, rules)

# Using the default configuration:
res <- fsi_eval(fsi, st_point(c(-74.0, 40.7)))

# Change the default discretization by modifying the default step value:
res <- fsi_eval(fsi, st_point(c(-74.0, 40.7)), discret_by=0.8)

# Change the default discretization by choosing the quantity of values 
## between the lower and upper values for the consequent domain:
res <- fsi_eval(fsi, st_point(c(-74.0, 40.7)), discret_length=200)

}
\references{
\href{https://ieeexplore.ieee.org/document/8015707}{Carniel, A. C.; Schneider, M. Fuzzy inference on fuzzy spatial objects (FIFUS) for spatial decision support systems. In Proceedings of the 2017 IEEE International Conference on Fuzzy Systems (FUZZ-IEEE 2017), pp. 1-6, 2017.}
}
