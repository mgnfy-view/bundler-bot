import { config as envConfig } from "dotenv";

import { config } from "./config.js";

envConfig();

function setup() {
    const environment = process.env.ENVIRONMENT;
    const rpcUrl = process.env.RPC_URL;
    const localhostRpcUrl = process.env.LOCAL_RPC_URL;
    const privateKey = process.env.PRIVATE_KEY;

    if (!environment || !rpcUrl || !localhostRpcUrl || !privateKey) throw new Error("Missing environment variables");
    if (environment !== "dev" && environment !== "production") throw new Error("Invalid environment");
    if (config.airdropEnabled) {
        for (const userDetails of config.airdropDetails) {
            if (!userDetails.user) throw new Error("User's public key not specified");
            if (userDetails.amount === 0) throw new Error("Airdrop amount can't be 0");
        }
    } else {
        config.airdropDetails = [];
    }

    const globalConfig = {
        environment,
        rpcUrl: environment === "dev" ? localhostRpcUrl : rpcUrl,
        privateKey,
        botConfig: config,
    };

    return globalConfig;
}

export { setup };
