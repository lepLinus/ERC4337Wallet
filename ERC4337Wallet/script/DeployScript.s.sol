// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Script, console2} from "forge-std/Script.sol";
import {BatchedWallet} from "../src/BatchedWallet.sol";
import {IEntryPoint} from "../src/interfaces/IEntryPoint.sol";

contract DeployScript is Script {
    function setUp() public {}
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        //replace this with real entrypoint address
        IEntryPoint anEntryPoint = new IEntryPoint();

        BatchedWallet wallet = new BatchedWallet(anEntryPoint);
        
        //Init deplyer as owner
        address deployer = vm.pubKey(vm.envUint("PRIVATE_KEY"));
        batchedWallet.initialize(deployer);

        vm.stopBroadcast();
    }
}