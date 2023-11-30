// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOps} from "foundry-23/foundry-fund-me-f23/lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script{
    function run() external {
        address MostRecentyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
    }   
}

contract WithDrawFundMe is Script{

}