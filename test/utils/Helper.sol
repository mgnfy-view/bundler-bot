// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { Test } from "forge-std/Test.sol";

import { BundlerBot } from "../../src/BundlerBot.sol";

contract Helper is Test {
    address internal constant ADDRESS_ZERO = address(0);
    uint256 internal constant MINIMUM_LP_AMOUNT = 1_000;

    address public constant WETH_ADDRESS_MAINNET = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant UNISWAP_V2_FACTORY_ADDRESS_MAINNET =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address public constant UNISWAP_V2_ROUTER_02_ADDRESS_MAINNET =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    address public deployer;
    address public user1;
    address public user2;

    BundlerBot public bundlerBot;

    function setUp() public {
        deployer = makeAddr("deployer");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        vm.startPrank(deployer);
        bundlerBot = new BundlerBot(UNISWAP_V2_ROUTER_02_ADDRESS_MAINNET);
        vm.stopPrank();
    }

    function _requestEth(address _receiver, uint256 _amount) internal {
        deal(_receiver, _amount);
    }
}
