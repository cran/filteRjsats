% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Data.R
\docType{data}
\name{raw_ats}
\alias{raw_ats}
\title{Example raw data from ats receiver after being read in by read_jsats}
\format{
\subsection{\code{raw_ats}}{

a dataframe with 123,636 rows and 12 columns:
\describe{
\item{ReceiverSN}{the serial number of the acoustic receiver which heard the
detection}
\item{Make}{The Manufacturer of the acoustic reciever}
\item{DateTime_Local}{The local date and time of the detection
tz = "America/Los_Angeles"}
\item{Tag_Decimal}{The decimal value of the tag ID code}
\item{Tag_Hex}{The hexadecimal value of the tag ID code}
\item{Tilt}{The tilt of the acoustic receiver from a vertical axis}
\item{Volt}{The voltage of the on-board battery of the receiver}
\item{Temp}{The water temperature outside of the receiver}
\item{SigStr}{The strength of the acoustic signal in dB}
\item{Freq}{The frequency of the acoustic signal in kHz}
\item{Thres}{The relative amount of external background noise,
signal threshold}
}
}
}
\usage{
raw_ats
}
\description{
A dataframe of ATS acoustic receiver data processed by \code{read_jsats()}
}
\keyword{datasets}
