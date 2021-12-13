# geospatialconsumer
Solidity smart contract for consuming geospatial / remote sensing data

This smart contract requests data from the Shamba geospatial oracle. 

Inputs:
    agg_x: ["string"]
    dataset_code: ['string'],
    selected_band: ["string"],
    geometry: ["object"],
    start_date: ["string"],
    end_date: ["string"],
    image_scale: ["integer"]
    

Data response stored in the 'currentData' variable.

Remember to fund your deployed contract with LINK in order to make data requests from oracles.

For more information about the Shamba geospatial oracle visit: 
https://docs.shamba.app