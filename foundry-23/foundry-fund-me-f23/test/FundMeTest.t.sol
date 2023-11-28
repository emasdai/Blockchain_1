// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";   // gunakan ../ untuk mengambil file pada folder yang sama induknya 
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test{
    FundMe fundMe;

    function setUp() external {
        // fundMe = new FundMe(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMInimumDollar() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);   
    }

    function testOwnerisMsgSender() public{
        assertEq(fundMe.i_owner(), msg.sender);
    }

    // function testPriceFeedisAccurate() public {
    //     uint256 version = fundMe.getVersion();
    //     assertEq(version, 4);
    // }
}