// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {BatchedWallet} from "../src/BatchedWallet.sol";
import {IEntryPoint} from "../src/interfaces/IEntryPoint.sol";
import {MockERC20} from "../src/mock/MockERC20.sol";

contract BatchedWalletTest is Test {
    BatchedWallet public batchedWallet;
    MockERC20 public token;

    //Not used but required for setup
    IEntryPoint public anEntryPoint;

    receive() external payable {}
    fallback() external payable{}

    function setUp() public {
        batchedWallet = new BatchedWallet(anEntryPoint);
        batchedWallet.initialize(address(this));
        
        vm.deal(address(this), 1 ether);
        token = new MockERC20(100000);
    }

    function test_ETHTransfer() public {
        bytes memory fun = abi.encode("");

        payable(batchedWallet).transfer(1);
        console2.log(address(batchedWallet).balance);

        batchedWallet.execute(address(token),1,fun);
        assertEq(address(token).balance, 1);
    }

    function test_BatchETHTransfer() public {
 
        address[] memory des = new address[](2);
        des[0] = address(token);
        des[1] = address(token);

        uint256[] memory values = new uint256[](2);
        values[0] = 1;
        values[1] = 2;

        bytes[] memory data = new bytes[](2);
        data[0] = "";
        data[1] = "";

        payable(batchedWallet).transfer(3);
        console2.log(address(batchedWallet).balance);


        uint256 balanceBefore = address(token).balance;

        batchedWallet.executeBatch(des,values,data);

        assertEq(address(token).balance, balanceBefore + 3);
    }

    function test_tokenTransfer() public {

        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", address(this),10);
        uint256 balanceBefore = token.balanceOf(address(this));

        //transfer tokens to batchedWallet
        token.transfer(address(batchedWallet),10);

        //transfer tokens back to this account
        batchedWallet.execute(address(token),0,data);

        assertEq(token.balanceOf(address(this)), balanceBefore);
    }
}
