# SAP Offline Distance Calculator

## Description

This repository contains a **Function Module** designed to calculate the **distance** between two geographical locations using the **Haversine formula**. The Haversine formula calculates the great-circle distance between two points on the Earth's surface, which is useful for applications that need to measure distance between geographic coordinates (latitude and longitude).

### Key Features:
- Calculates the distance in kilometers between two geographic locations.
- Uses **latitude** and **longitude** as input parameters.
- Can be integrated with SAP ABAP systems to work with employee location data.

## Functionality

The **Z_CALCULATE_DISTANCE** function module receives the following inputs:

- `IV_LAT1` and `IV_LON1`: Latitude and Longitude of the first location.
- `IV_LAT2` and `IV_LON2`: Latitude and Longitude of the second location.

It then calculates the **distance** between the two points using the Haversine formula and returns the result as **EV_DISTANCE** in kilometers.

## Example Usage

```abap
DATA: LV_DISTANCE TYPE F.

CALL FUNCTION 'Z_CALCULATE_DISTANCE'
  EXPORTING
    IV_LAT1 = 30.0330 " Example: Latitude of location 1
    IV_LON1 = 31.2330 " Example: Longitude of location 1
    IV_LAT2 = 30.0335 " Example: Latitude of location 2
    IV_LON2 = 31.2335 " Example: Longitude of location 2
  IMPORTING
    EV_DISTANCE = LV_DISTANCE.

WRITE: / 'Distance between points:', LV_DISTANCE, 'KM'.
