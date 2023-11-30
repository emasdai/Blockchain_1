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
    uint256 constant GAS_PRICE = 1;

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
        assertEq(fundMe.getOwner(), msg.sender);
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

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _; // modifier selalu diakhiri dengan _ 
    }

    function testOnlyOwnerCanWithdraw() public funded() {
         
        vm.prank(USER);
        vm.expectRevert();  // next line haruslah revert
        fundMe.withdraw();

    }

    function testWithDrawWithSingleFunder() public funded() {

        // Arrange 
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;
        // Act
        
        vm.prank(fundMe.getOwner());    // hanya owner yang bisa withdraw   
        fundMe.withdraw();

        // Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);
    }

    function testWithDrawFromMultipleFunders() public funded() {
        // Arrrange
        uint160 numberOfFunder = 10;
        uint160 startingFunderIndex = 2;
        for(uint160 i = startingFunderIndex; i < numberOfFunder; i++){  // menggunakan uint160
            hoax(address(i), SEND_VALUE); // hoax = prank + deal, menambahkan address dan ether value 
            fundMe.fund{value: SEND_VALUE}();   // value sudah diset dari awal di SEND_VALUE 
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // Act
        vm.startPrank(fundMe.getOwner());    // sama seperti startbroadcast hanya owner yang bisa withdraw   
        fundMe.withdraw();
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }

    function testWithDrawFromMultipleFundersChiper() public funded() {
        // Arrrange
        uint160 numberOfFunder = 10;
        uint160 startingFunderIndex = 2;
        for(uint160 i = startingFunderIndex; i < numberOfFunder; i++){  // menggunakan uint160
            hoax(address(i), SEND_VALUE); // hoax = prank + deal, menambahkan address dan ether value 
            fundMe.fund{value: SEND_VALUE}();   // value sudah diset dari awal di SEND_VALUE 
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // Act
        vm.startPrank(fundMe.getOwner());    // sama seperti startbroadcast hanya owner yang bisa withdraw   
        fundMe.cheaperWithDraw();   //menggunakan function cheaperwithdraw agar gas fee optimize
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }

}