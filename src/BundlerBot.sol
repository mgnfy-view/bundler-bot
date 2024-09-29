// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IUniswapV2Router02 } from "./interfaces/IUniswapV2Router02.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { Token } from "./Token.sol";

contract BundlerBot {
    address private constant ADDRESS_ZERO = address(0);
    address private s_uniswapV2Router02;

    event BundlerBot__TokenCreated(address token, uint256 lpAmount);

    error BundlerBot__ArrayLengthsDoNotMatch();

    constructor(address _uniswapV2Router02) {
        s_uniswapV2Router02 = _uniswapV2Router02;
    }

    /**
     * @notice Allows anyone to launch a token with a custom name, symbol, and total supply,
     * airdrop it to a list of users, and then add the remaining tokens to Uniswap V2 pool.
     * @param _name The token's name.
     * @param _symbol The token's symbol.
     * @param _totalSupply The token's total supply.
     * @param _users A list of users eligible for the token airdrop.
     * @param _amounts The airdrop amounts for each eligible user.
     * @param _deadline The deadline before which the Uniswap V2 pool should be created.
     * @return The token's address.
     */
    function createToken(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        address[] memory _users,
        uint256[] memory _amounts,
        uint256 _deadline
    )
        external
        payable
        returns (address, uint256)
    {
        Token token = new Token(_name, _symbol, _totalSupply);

        uint256 usersLength = _users.length;
        if (usersLength != _amounts.length) revert BundlerBot__ArrayLengthsDoNotMatch();
        for (uint256 count; count < usersLength; ++count) {
            token.transfer(_users[count], _amounts[count]);
        }

        uint256 remainingTokenBalance = token.balanceOf(address(this));
        token.approve(s_uniswapV2Router02, remainingTokenBalance);
        (,, uint256 lpAmount) = IUniswapV2Router02(s_uniswapV2Router02).addLiquidityETH{
            value: msg.value
        }(
            address(token),
            remainingTokenBalance,
            remainingTokenBalance,
            msg.value,
            ADDRESS_ZERO,
            _deadline
        );

        emit BundlerBot__TokenCreated(address(token), lpAmount);

        return (address(token), lpAmount);
    }

    /**
     * @notice Gets the Uniswap V2 router 02 address.
     * @return The Uniswap V2 router 02 address.
     */
    function getUniswapV2Router02Address() external view returns (address) {
        return s_uniswapV2Router02;
    }
}
