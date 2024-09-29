const config = {
    tokenName: "Guts",
    tokenSymbol: "GUTS",
    tokenTotalSupply: 1_000,
    airdropEnabled: false,
    airdropDetails: [
        {
            user: "0xE5261f469bAc513C0a0575A3b686847F48Bc6687", // user's public key
            amount: 10, // in token
        },
        {
            user: "0x25eF04fcCe2F6555B204a28fE1cBb79F7D12279c",
            amount: 10,
        },
    ],
    ethLpAmount: 0.25,
    bundlerBotAddress: "0x81ED8e0325B17A266B2aF225570679cfd635d0bb",
};

export { config };
