// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
contract GeospatialConsumer is ChainlinkClient, ConfirmedOwner {
using Chainlink for Chainlink.Request;
uint256 constant private ORACLE_PAYMENT = 0.1 * 10 ** 19; // 1 LINK
uint256 public currentData;
//declaring Shamba oracle address and jobid
address private oracle;
bytes32 private jobId;
//declaring user specified parameters
string public agg_x;
string public dataset_code;
string public selected_band;
string public start_date;
string public end_date;
uint32 public image_scale;
string public geometry;
uint256 public threshold;

//this event is emitted on successfull request fulfillment
event RequestGeospatialDataFulfilled(
bytes32 indexed requestId,
uint256 indexed data
);
//this is where we initialize state variables
constructor() ConfirmedOwner(msg.sender){
setPublicChainlinkToken();
//here we initialize the oracle address and jobids
oracle =  0xd5CEd81bcd8D8e06E6Ca67AB9988c92CA78EEfe6;
jobId =  "ef0eef0ffec44dd5b87279434bb6f90b";
//You can get these parameters from the Shamba contracts tool
agg_x = "agg_mean";
dataset_code = "COPERNICUS/S2_SR";
selected_band = "NDVI";
image_scale = 250;
start_date = "2021-10-01";
end_date = "2021-10-31";
geometry = "{'type':'FeatureCollection','features':[{'type':'Feature','properties':{},'geometry':{'type':'Polygon','coordinates':[[[19.51171875,4.214943141390651],[18.28125,-4.740675384778361],[26.894531249999996,-4.565473550710278],[27.24609375,1.2303741774326145],[19.51171875,4.214943141390651]]]}}]}";
threshold = 1;

//initializing ends

}
//here we build the data request
function requestGeospatialData()
public
onlyOwner
{
Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillGeospatialData.selector);
req.add("agg_x", agg_x);
req.add("dataset_code", dataset_code);
req.add("selected_band", selected_band);
req.add("geometry", geometry);
req.add("start_date", start_date);
req.add("end_date", end_date);
req.add("image_scale", uint2str(image_scale));  //we convert image_scale from uint to string
//Multiply the result by 1000000000000000000 to remove decimals
//int timesAmount = 10**18;
//req.addInt("times", timesAmount);
sendChainlinkRequestTo(oracle, req, ORACLE_PAYMENT);
}
//This is the callback function
//currentData is the variable that holds the data from the oracle
function fulfillGeospatialData(bytes32 _requestId, uint256 _data)
public
recordChainlinkFulfillment(_requestId)
{
emit RequestGeospatialDataFulfilled(_requestId, _data);
currentData = _data;
}
//helper function to convert uint  to string
function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

}
 