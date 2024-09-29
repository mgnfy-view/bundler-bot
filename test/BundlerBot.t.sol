// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { IUniswapV2Factory } from "./utils/IUniswapV2Factory.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import { Helper } from "./utils/Helper.sol";

contract BundlerBotTest is Helper {
    function test_healthCheck() public pure {
        assertEq(uint256(1), uint256(1));
    }

    function test_createTokenNoAirdrop() public {
        string memory name = "Guts";
        string memory symbol = "GUTS";
        uint256 totalSupply = 100e18;
        address[] memory airdropReceivers = new address[](0);
        uint256[] memory airdropAmounts = new uint256[](0);
        uint256 deadline = type(uint256).max;
        uint256 ethLpAmount = 0.2 ether;

        _requestEth(deployer, ethLpAmount);

        (address token, uint256 lpTokens) = bundlerBot.createToken{ value: ethLpAmount }(
            name, symbol, totalSupply, airdropReceivers, airdropAmounts, deadline
        );

        address pair = IUniswapV2Factory(UNISWAP_V2_FACTORY_ADDRESS_MAINNET).getPair(
            WETH_ADDRESS_MAINNET, token
        );

        assertEq(IERC20Metadata(token).name(), name);
        assertEq(IERC20Metadata(token).symbol(), symbol);
        assertEq(IERC20Metadata(token).totalSupply(), totalSupply);
        assertEq(IERC20(pair).balanceOf(ADDRESS_ZERO), lpTokens + MINIMUM_LP_AMOUNT);
        assertEq(IERC20(token).balanceOf(pair), totalSupply);
        assertEq(IERC20(WETH_ADDRESS_MAINNET).balanceOf(pair), ethLpAmount);
    }

    function test_createTokenWithAirdrop() public {
        string memory name = "Guts";
        string memory symbol = "GUTS";
        uint256 totalSupply = 100e18;
        address[] memory airdropReceivers = new address[](2);
        airdropReceivers[0] = user1;
        airdropReceivers[1] = user2;
        uint256[] memory airdropAmounts = new uint256[](2);
        airdropAmounts[0] = 2e18;
        airdropAmounts[1] = 10e18;
        uint256 deadline = type(uint256).max;
        uint256 ethLpAmount = 0.2 ether;

        _requestEth(deployer, ethLpAmount);

        (address token,) = bundlerBot.createToken{ value: ethLpAmount }(
            name, symbol, totalSupply, airdropReceivers, airdropAmounts, deadline
        );

        address pair = IUniswapV2Factory(UNISWAP_V2_FACTORY_ADDRESS_MAINNET).getPair(
            WETH_ADDRESS_MAINNET, token
        );

        assertEq(IERC20(token).balanceOf(user1), airdropAmounts[0]);
        assertEq(IERC20(token).balanceOf(user2), airdropAmounts[1]);
        assertEq(IERC20(token).balanceOf(pair), totalSupply - airdropAmounts[0] - airdropAmounts[1]);
        assertEq(IERC20(WETH_ADDRESS_MAINNET).balanceOf(pair), ethLpAmount);
    }

    function test_getUniswapV2Router02Address() public view {
        assertEq(bundlerBot.getUniswapV2Router02Address(), UNISWAP_V2_ROUTER_02_ADDRESS_MAINNET);
    }
}
