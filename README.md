Healthcare Billing DApp 🏥
A decentralised application built on Ethereum blockchain to prevent fraudulent medical billing in Revenue Cycle Management (RCM).
Problem Statement
Medical billing fraud costs the healthcare industry billions annually. Bills get tampered with, duplicated, or falsely approved. This DApp prevents fraud by requiring dual-signature approval stored immutably on the Ethereum blockchain.
Solution
Using smart contracts, every medical bill requires independent approval from both Hospital Admin AND Lab Admin before insurance can process the claim. No single party can commit fraud alone.
Tech Stack

Solidity (Smart Contract)
Ethereum Blockchain (Remix VM)
React.js (Frontend)
Web3.js
MetaMask
Ganache

Features

Patient submits medical bill with CPT codes
Hospital Admin approves bill on blockchain
Lab Admin independently approves bill
Insurance can verify bill authenticity instantly
Tamper-proof immutable records
Prevents upcoding and duplicate billing fraud

Original Repository
https://github.com/Rishabh42/HealthCare-Insurance-Ethereum
How to Run

Clone the repository
Install dependencies: cd Web-client && npm install
Start the app: npm start
Open Remix IDE and deploy HealthCare.sol
Connect MetaMask to local blockchain
Interact with the DApp at localhost:3000

Smart Contract
The HealthCare.sol contract implements:

newRecord() — Patient submits medical bill
signRecord() — Admin approves bill
isApproved() — Verify bill authenticity

RCM Context
Built by someone with real RCM industry experience across AR Collection, VOB, Arbitration and Quality Assurance departments.