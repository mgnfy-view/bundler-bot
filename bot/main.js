import { ethers } from "ethers";

import { setup } from "./utils/setup.js";
import { BUNDLER_BOT_BUILD_PATH, CREATE_TOKEN_EVENT } from "./utils/constants.js";
import { getAbi } from "./utils/getAbi.js";

async function main() {
    const globalConfig = setup();
    const botConfig = globalConfig.botConfig;
    const provider = new ethers.JsonRpcProvider(globalConfig.rpcUrl);
    const signer = new ethers.Wallet(globalConfig.privateKey, provider);
    const bundlerBot = new ethers.Contract(
        globalConfig.botConfig.bundlerBotAddress,
        getAbi(BUNDLER_BOT_BUILD_PATH),
        provider
    );

    // Listen for the token creation event, log it, and stop the bot
    bundlerBot.on(CREATE_TOKEN_EVENT, (tokenAddress, lpAmount) => {
        console.log(`Token deployed at address ${tokenAddress}`);
        botConfig.airdropEnabled ? console.log("Token airdropped to eligible users") : null;
        console.log(`${ethers.formatEther(lpAmount)} LP tokens were burned`);
        process.exit(0);
    });

    // Display network details
    const networkDetails = await provider.getNetwork();
    console.log(`Connected to network: ${networkDetails.name}`);
    console.log(`Network chainId: ${networkDetails.chainId.toString()}\n`);

    console.log(
        `Creating token "${botConfig.tokenName}" with symbol "${botConfig.tokenSymbol}" and total supply "${botConfig.tokenTotalSupply}"`
    );
    botConfig.airdropEnabled
        ? console.log(`Token airdrop enabled. ${botConfig.airdropDetails.length} users will receive airdrop\n`)
        : console.log("Token airdrop not enabled\n");

    // Additional parameters required for the BundlerBot::createToken() function
    const users = botConfig.airdropDetails.map((userDetail) => userDetail.user);
    const amounts = botConfig.airdropDetails.map((userDetail) => ethers.parseEther(userDetail.amount.toString()));
    const deadline = Math.floor(Date.now() / 1000) + 2 * 60; // 2 minutes deadline

    // Attach signer to the contract and create the token, airdrop if airdrop is enabled, add liquidity
    // to Uniswap V2, and burn the lp tokens
    let bundlerBotWithSigner = bundlerBot.connect(signer);
    const tx = await bundlerBotWithSigner.createToken(
        botConfig.tokenName,
        botConfig.tokenSymbol,
        ethers.parseEther(botConfig.tokenTotalSupply.toString()),
        users,
        amounts,
        deadline,
        {
            value: ethers.parseEther(botConfig.ethLpAmount.toString()),
        }
    );
    await tx.wait();
}

main().catch((error) => console.error(error));
