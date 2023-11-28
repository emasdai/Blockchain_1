// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";

contract HelperConfig {
    // jika kita berada di local chain seperti anvil, kita akan deploy mockup
    // mendapatkan address yang suda ada dari network

    NetworkConfig public activeNetworkConfig;   // mengatur network yang akan digunakan

    struct NetworkConfig {
        //   grouping together related data
        address priceFeed;
    }

    constructor(){  // memilih network mana yang digunakan, jika chain id = 1155111 maka pake sepoliaEth
        if (block.chainid == 1155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) { // memory = variable is in memory and it exists while a function is being called
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed : 0x694AA1769357215DE4FAC081bf1f309aDC325306  // address ETH/USD di SepoliaEth 
            });
            return sepoliaConfig;
    } 

    function getAnvilEthConfig() public pure returns (NetworkConfig memory) {

    }

}