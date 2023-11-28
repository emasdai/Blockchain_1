// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";

contract HelperConfig {
    // jika kita berada di local chain seperti anvil, kita akan deploy mockup
    // mendapatkan address yang suda ada dari network

    struct NetworkConfig {
        //   grouping together related data
        address priceFeed;
    
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) { // memory = variable is in memory and it exists while a function is being called
        
    } 

    function getAnvilEthConfig() public pure returns (NetworkConfig memory) {
        
    }

}