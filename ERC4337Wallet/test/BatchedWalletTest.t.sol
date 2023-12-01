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


    function setUp() public {
        batchedWallet = new BatchedWallet(anEntryPoint);
        batchedWallet.initialize(address(this));

        token = new MockERC20(100000);
    }

    function test_ETHTransfer() public {
        batchedWallet.execute(token,1,"");
        assertEq(token.balance(), 1);
    }

    function test_BatchETHTransfer() public {

        address[2] memory des = new address[2];
        des[0] = token;
        des[1] = token;

        uint256[2] memory values = new uint256[2];
        values[0] = 1;
        values[1] = 2;

        bytes[2] memory data = new bytes[2];

        uint256 balanceBefore = token.balance();

        batchedWallet.executeBatch(des,values,data);

        assertEq(token.balance(), balanceBefore + 3);
    }

    function test_tokenTransfer() public {

        bytes memory data = abi.encodeWithSelector("transfer(address,uint256)", address(this),10);
        uint256 balanceBefore = token.balanceOf(address(this));

        //transfer tokens to batchedWallet
        token.transfer(batchedWallet,10);

        //transfer tokens back to this account
        batchedWallet.execute(token,0,data);

        assertEq(token.balanceOf(address(this)), balanceBefore + 10);
    }
}
