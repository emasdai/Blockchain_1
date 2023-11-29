// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script{
    function run() external returns (FundMe) {
        // untuk melakukan testing sebelum transaksi
        HelperConfig helperConfig = new HelperConfig(); // digunakan diawal agar tidak memakai gas fee saat running line ini
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // saat mengunakan transaksi sebenarnya.
        vm.startBroadcast();
        FundMe fundMe= new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}