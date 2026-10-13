import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks:{
    sepolia:{
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [process.env.SEPOLIA_API_KEY!]
    }
  }
};

export default config;
