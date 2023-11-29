// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";   // gunakan ../ untuk mengambil file pada folder yang sama induknya 
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test{
    FundMe fundMe;

    address USER = makeAddr("user");    // digunakan untuk melakukan testing orang yang akan mengirimkan cypto
    uint256 constant SEND_VALUE = 1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        // fundMe = new FundMe(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);    // set percobaan dengan balance dan value yang sudah ditetapkan
    }

    function testMInimumDollar() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);   
    }

    function testOwnerisMsgSender() public{
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedisAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsMewithEnoughEth() public {
        vm.expectRevert();  // line setelah ini haruslah salah, secara logika dan fungsi
        fundMe.fund();
    }

    function testFundDataUpdateStructure() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();    // mengirim lebih dari 5 dollar ( minimum di FundMe.sol)

        uint256 amountFunded = fundMe.getAddresstoAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE); // memastikan jumlah yang di fund sama dengan SEND_VALUE
    }

    function testAddsFundertoArraytoFunders() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER); // memastikan funder adalah user
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        vm.prank(USER);
        vm.expectRevert();  // next line haruslah revert
        fundMe.withdraw();

    }

}