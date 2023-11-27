// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";   // gunakan ../ untuk mengambil file pada folder yang sama induknya 

contract FundMeTest is Test{
    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }

    function testMInimumDollar() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);   
    }

    function testOwnerisMsgSender() public{
        assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedisAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}