<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/mgnfy-view/bundler-bot">
    <img src="assets/icon.svg" alt="Logo" width="80" height="80">
  </a> -->

  <h3 align="center">Bundler Bot</h3>

  <p align="center">
    A bundler bot allows you to create a token, airdrop it to some users, create a Uniswap V2 pool with it, and burn the LP tokens all in a single transaction
    <br />
    <a href="https://github.com/mgnfy-view/bundler-bot/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/mgnfy-view/bundler-bot/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

This bundler bot allows you to create a token with custom parameters (name, symbol, and total supply). The token can be airdropped to some users if the airdrop feature is enabled. After the airdrop (if enabled), the bot creates a Uniswap V2 pool with the remaining tokens, and burns the received LP tokens. All of this occurs in a single transaction.

### Built With

- Foundry
- Solidity
- Node.js
- Javascript
- Ethers.js
- pnpm

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

Make sure you have git, node.js, pnpm, rust, foundry, and make installed and configured on your system.

### Installation

Clone the repo,

```shell
git clone https://github.com/mgnfy-view/bundler-bot.git
```

Cd into the repo, and install the necessary dependencies

```shell
cd bundler-bot
pnpm install
forge build
```

Start by filling out the .env.example file, and rename it to .env. Use `export ENVIRONMENT="dev"` for local testing, or `export ENVIRONMENT="production"` for going live on Eth mainnet.

Load your terminal with the environment variables in your `.env` file using

```shell
source .env
```

Run tests by

```shell
forge test --fork-url ${RPC_URL}
```

This will run a fork test.

Deploy the `BundlerBot` contract using

```shell
forge script script/Deploy.s.sol --broadcast --rpc-url <YOUR-RPC-URL-HERE> --private-key <YOUR-PRIVATE-KEY-HERE>
```

Next, customize the bot's characteristics using the `./bot/utils/config.js` file. You're ready to run the bot now!

```shell
pnpm run bot
```

That's it, you are good to go now!

<!-- ROADMAP -->

## Roadmap

-   [x] Smart contract development
-   [x] Unit tests
-   [x] Bot development
-   [x] Write a good README.md

See the [open issues](https://github.com/mgnfy-view/bundler-bot/issues) for a full list of proposed features (and known issues).

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- CONTACT -->

## Reach Out

Here's a gateway to all my socials, don't forget to hit me up!

[![Linktree](https://img.shields.io/badge/linktree-1de9b6?style=for-the-badge&logo=linktree&logoColor=white)][linktree-url]

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/mgnfy-view/bundler-bot.svg?style=for-the-badge
[contributors-url]: https://github.com/mgnfy-view/bundler-bot/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/mgnfy-view/bundler-bot.svg?style=for-the-badge
[forks-url]: https://github.com/mgnfy-view/bundler-bot/network/members
[stars-shield]: https://img.shields.io/github/stars/mgnfy-view/bundler-bot.svg?style=for-the-badge
[stars-url]: https://github.com/mgnfy-view/bundler-bot/stargazers
[issues-shield]: https://img.shields.io/github/issues/mgnfy-view/bundler-bot.svg?style=for-the-badge
[issues-url]: https://github.com/mgnfy-view/bundler-bot/issues
[license-shield]: https://img.shields.io/github/license/mgnfy-view/bundler-bot.svg?style=for-the-badge
[license-url]: https://github.com/mgnfy-view/bundler-bot/blob/master/LICENSE.txt
[linktree-url]: https://linktr.ee/mgnfy.view
