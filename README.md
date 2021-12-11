# geospatialconsumer
Solidity smart contract for consuming geospatial / remote sensing data

This smart contract requests data from the Shamba geospatial oracle. 

Inputs:
    dataset_code: ['string'],
    selected_band: ["string"],
    geometry: ["object"],
    start_date: ["string"],
    end_date: ["string"],
    image_scale: ["string"],
    agg_x: ["string"]

Data response stored in 'currentData' variable.

For more information visit: https://docs.shamba.app