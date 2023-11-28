// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script{
    function run() external returns (FundMe) {
        vm.startBroadcast();
        FundMe fundMe=  new FundMe(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);
        vm.stopBroadcast();
        return fundMe;
    }
}