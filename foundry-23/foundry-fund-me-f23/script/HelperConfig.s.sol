// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    // jika kita berada di local chain seperti anvil, kita akan deploy mockup
    // mendapatkan address yang suda ada dari network

    NetworkConfig public activeNetworkConfig;   // mengatur network yang akan digunakan
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        //   grouping together related data
        address priceFeed;
    }

    constructor(){  // memilih network mana yang digunakan, jika chain id = 1155111 maka pake sepoliaEth
        if (block.chainid == 1155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) { // memory = variable is in memory and it exists while a function is being called
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed : 0x694AA1769357215DE4FAC081bf1f309aDC325306  // address ETH/USD di SepoliaEth 
            });
            return sepoliaConfig;
    } 

    // jika yang digunakan adalah configurasi anvil
    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {

        if(activeNetworkConfig.priceFeed != address(0)){    //default value
            return activeNetworkConfig; // jika kita sudah membuat active network, maka akan kembali ke active network yang digunakan
            
        }
        
        // membuat active network jika belum pernah dibuat sebelumnya
        vm.startBroadcast();   // menggunakan anvil saat melakukan config
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast(); 

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }

}