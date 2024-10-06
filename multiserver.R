
#' Multiserver Queue Simulation
#'
#' Simulates a multiserver queue system where customers are served in a first come, first serve manner.
#'
#' @param Arrivals A numeric vector of customer arrival times.
#' @param ServiceTimes A numeric vector of customer service times.
#' @param NumServers An integer specifying the number of servers available (default is 1).
#' @return A tibble containing the arrival times, start times, end times, and chosen server for each customer.
#' @examples
#' Arrivals <- c(1, 3, 5)
#' ServiceTimes <- c(2, 1, 3)
#' Multiserver(Arrivals, ServiceTimes, NumServers = 2)
#' @export
Multiserver <- function(Arrivals, ServiceTimes, NumServers = 1) {
  if (any(Arrivals <= 0 | ServiceTimes <= 0) || NumServers <= 0) {
    stop("Arrivals, ServiceTimes, and NumServers must be positive.")
  }
  if (length(Arrivals) != length(ServiceTimes)) {
    stop("Arrivals and ServiceTimes must have the same length.")
  }

  NumCust <- length(Arrivals)
  AvailableFrom <- rep(0, NumServers)

  ChosenServer <- ServiceBegins <- ServiceEnds <- rep(0, NumCust)

  for (i in seq_along(Arrivals)) {
    avail <- min(AvailableFrom)
    ChosenServer[i] <- which.min(AvailableFrom)
    ServiceBegins[i] <- max(avail, Arrivals[i])
    ServiceEnds[i] <- ServiceBegins[i] + ServiceTimes[i]
    AvailableFrom[ChosenServer[i]] <- ServiceEnds[i]
  }

  out <- tibble::tibble(Arrivals, ServiceBegins, ChosenServer, ServiceEnds)
  return(out)
}

