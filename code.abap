FUNCTION Z_CALCULATE_DISTANCE.
*"----------------------------------------------------------------------
*"* Function module to calculate the distance between two geo locations
*"* using the Haversine Formula
*"----------------------------------------------------------------------
*"  IMPORT PARAMETERS:
*"      IV_LAT1     TYPE F     " Latitude of the first location
*"      IV_LON1     TYPE F     " Longitude of the first location
*"      IV_LAT2     TYPE F     " Latitude of the second location
*"      IV_LON2     TYPE F     " Longitude of the second location
*"
*"  EXPORT PARAMETERS:
*"      EV_DISTANCE TYPE F     " The distance between the two locations in kilometers
*"----------------------------------------------------------------------
  
  CONSTANTS: LC_EARTH_RADIUS_KM TYPE DECFLOAT34 VALUE '6371'.  " Earth's radius in kilometers
  CONSTANTS: LC_PI TYPE DECFLOAT34 VALUE '3.141592653589793'. " Hardcoded PI value
  
  DATA: LV_DLAT TYPE F,
        LV_DLON TYPE F,
        LV_A    TYPE F,
        LV_C    TYPE F,
        LV_LAT1_RAD TYPE F,
        LV_LON1_RAD TYPE F,
        LV_LAT2_RAD TYPE F,
        LV_LON2_RAD TYPE F,
        LV_IV_X TYPE F,
        LV_IV_Y TYPE F,
        LV_EV_ATAN2 TYPE F.
        
  " Convert coordinates from degrees to radians
  LV_LAT1_RAD = IV_LAT1 * ( LC_PI / 180 ).
  LV_LON1_RAD = IV_LON1 * ( LC_PI / 180 ).
  LV_LAT2_RAD = IV_LAT2 * ( LC_PI / 180 ).
  LV_LON2_RAD = IV_LON2 * ( LC_PI / 180 ).

  LV_DLAT = LV_LAT2_RAD - LV_LAT1_RAD.
  LV_DLON = LV_LON2_RAD - LV_LON1_RAD.

  LV_A = SIN( LV_DLAT / 2 ) ** 2 + COS( LV_LAT1_RAD ) * COS( LV_LAT2_RAD ) * SIN( LV_DLON / 2 ) ** 2.

  LV_IV_Y = SQRT( LV_A ).
  LV_IV_X = SQRT( 1 - LV_A ).

  CALL METHOD CL_GIS_GEOCOD_CAL=>ATAN2(
    EXPORTING
      IV_X = LV_IV_X
      IV_Y = LV_IV_Y
    IMPORTING
      EV_ATAN2 = LV_EV_ATAN2
  ).

  LV_C = 2 * LV_EV_ATAN2.

  " Calculate the distance in kilometers
  EV_DISTANCE = LC_EARTH_RADIUS_KM * LV_C.

ENDFUNCTION.
