#***********************************************************************
#  Makefile for AMSU level 1 to BUFR converters
#  Note that it is not build 64 bit executables since libw3 isn't built
#  64 bit.
#***********************************************************************
#***********************************************************************
#
#     DATE        SCR#    ENGINEER    DESCRIPTION
#    ---------   ------   --------   -----------------
#    12JUN2006  20061163    ccf      initial version
#***********************************************************************

FC = gfortran

FCFLAGS = 

LIB_PATH=/home/zxt/NOAA/zxt/2014.5.23.liuzc_supply_L1B_to_BUFR_code/AMSU_CODE/ncep_bufr/ncepbufr_w64.a /home/zxt/NOAA/zxt/2014.5.23.liuzc_supply_L1B_to_BUFR_code/AMSU_CODE/w3lib/libw3.a

all: a.exe

a.o: a.f90
	$(FC) -c a.f90
a.exe: a.o
	$(FC) a.o $(LIB_PATH)

clean:
	rm -f *.o *.exe
	
