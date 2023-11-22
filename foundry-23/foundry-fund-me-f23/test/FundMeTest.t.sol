// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";   // gunakan ../ untuk mengambil file pada folder yang sama induknya 

contract FundMeTest is Test{
    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }

    function testDemo() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
}