# geospatialconsumer
Solidity smart contract for consuming geospatial data

This smart contract gets data from the Shamba geospatial oracle. 

# Inputs

    agg_x: ["string"]
    dataset_code: ['string'],
    selected_band: ["string"],
    image_scale: ["integer"],
    start_date: ["string"],
    end_date: ["string"],
    geometry: ["object"]
    

# Example Solidity request

 req.add("data","{"agg_x" : "agg_mean","dataset_code" : "MODIS/006/MOD11A1","selected_band" : "LST_Day_1km","image_scale" : 1000,"start_date" : "2021-12-01","end_date" : "2022-01-31","geometry" : {"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"Polygon","coordinates":[[[13.886718749999998,-0.17578097424708533],[27.0703125,4.915832801313164],[27.0703125,-6.664607562172573],[13.886718749999998,-0.17578097424708533]]]}}]}}");


# Response  

 int256 stored in the 'currentData' variable.

# How to get the object for the geometry parameter

 Define your area of interest and get its GeoJson here:
 https://contracts.shamba.app/

# Fund contract with LINK

 Remember to fund your deployed contract with LINK in order to make data requests from Chainlink oracles. In this particular case the contract pays 1 LINK per request.

# Chainlink Node Job Spec
 
 The data request format in this smart contract works with this node job spec:
 https://github.com/shambadynamic/Chainlink-Node-TOML-Job-Spec-Shamba

# Learn more about the Shamba GeoAPI
For more information about the Shamba geospatial oracle visit: 
https://docs.shamba.app