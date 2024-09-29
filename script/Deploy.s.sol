// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { Script } from "forge-std/Script.sol";

import { BundlerBot } from "../src/BundlerBot.sol";

contract Deploy is Script {
    address public constant UNISWAP_V2_ROUTER_02_ADDRESS_MAINNET =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    BundlerBot public bundlerBot;

    function run() public {
        vm.startBroadcast();
        bundlerBot = new BundlerBot(UNISWAP_V2_ROUTER_02_ADDRESS_MAINNET);
        vm.stopBroadcast();
    }
}
