// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.19;

import {Scrip, console} from "../lib/forge-std/src/Script.sol";
import {DevOps} from "foundry-23/foundry-fund-me-f23/lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 0.01 ether;
    function FundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe( payable (mostRecentlyDeployed)).fund{value: SEND_VALUE}();  // mengirimkan uang sejumlah value
        vm.stopBroadcast();
        console.log("Funded fund me with %s", SEND_VALUE);
    }

    function run() external {
        address MostRecentyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        FundFundMe(MostRecentyDeploy);
    }   
}

contract WithDrawFundMe is Script{

}