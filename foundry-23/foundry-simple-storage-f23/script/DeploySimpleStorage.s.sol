
// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.19;

import {Script} from "foundry-23/foundry-simple-storage-f23/lib/forge-std/src/Script.sol";
import {SimpleStorage} from "foundry-23/foundry-simple-storage-f23/src/SimpleStorage.sol";

contract DeploySimpleStorage is Script{
    function run() external returns (SimpleStorage){
        vm.startBroadcast();    // memanggil function startbroadcast dari vm (foundry)
        SimpleStorage simplestorage = new SimpleStorage();  // membuat storage baru
        vm.stopBroadcast();
        return simplestorage;
    }
}

