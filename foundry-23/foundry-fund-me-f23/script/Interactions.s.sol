// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();  // mengirimkan uang sejumlah value
        vm.stopBroadcast();
        console.log("Funded fund me with %s", SEND_VALUE);
    }

    function run() external {
        address MostRecentyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(MostRecentyDeploy);
    
    }   
}

contract WithDrawFundMe is Script{
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw(); 
        vm.stopBroadcast();
        console.log("Withdraw FundMe balance!");
    }

    function run() external {
        address MostRecentyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        WithDrawFundMe(MostRecentyDeploy);
    }   
}