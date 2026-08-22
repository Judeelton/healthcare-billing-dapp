Healthcare RCM Billing DApp 🏥
Decentralised Medical Billing Fraud Prevention on Ethereum

A blockchain-based decentralised application that prevents fraudulent medical billing in Revenue Cycle Management (RCM) - built by someone with direct industry experience of the problem it solves.

The Problem

Medical billing fraud costs the healthcare industry billions annually. Bills get tampered with, upcoded (submitting more expensive CPT codes than procedures actually performed), duplicated across payers, or falsely approved by a single party acting alone. In traditional RCM workflows, there is no tamper-proof audit trail — trust is assumed, not enforced.

This DApp removes the need for trust by requiring dual-signature approval from two independent parties, stored immutably on the Ethereum blockchain. No single admin can approve a fraudulent claim alone.

Real-World Context

This project was built by someone with hands-on RCM experience across VOB (Verification of Benefits), AR Collection, Arbitration, and QA departments at a US healthcare billing company. The fraud patterns this DApp prevents — COVID-19 lab billing fraud, upcoding, duplicate claim submission — were observed directly in that professional context.

CPT codes used in the test data (CPT-99285, CPT-71046, CPT-93010) are real medical procedure codes, not placeholder values. The dual-party approval architecture reflects the actual multi-stakeholder verification structure of RCM workflows.

How It Works
Dual-Signature Approval Flow
Patient submits a bill - calls newRecord() with their name, CPT codes, and bill amount. Transaction is mined to the blockchain with a unique record ID. Both hospitalApproved and labApproved flags are set to false
Hospital Admin approves - switches to the Hospital Admin wallet, calls signRecord() with the record ID. The contract verifies msg.sender matches the stored hospitalAdmin address. Sets hospitalApproved = true, increments signatureCount
Lab Admin approves independently — switches to the Lab Admin wallet, calls signRecord() with the same record ID. Contract verifies msg.sender matches labAdmin. Sets labApproved = true, increments signatureCount to 2
Insurance verifies - any party calls isApproved() with the record ID. Returns true if signatureCount >= 2. No gas cost — read-only call. Insurance can now process the claim with confidence
Fraud Prevention Guarantees
Two separate private keys are required - no single party controls approval
require statements prevent double-approval attempts (transaction reverts with explicit error)
Unauthorised wallet addresses are rejected at the contract level
All approvals are permanently recorded on-chain with timestamps and transaction hashes
Records cannot be modified or deleted after submission
Smart Contract

HealthCare.sol — written in Solidity ^0.8.0 with full NatSpec documentation

solidity
newRecord()     — Patient submits medical bill with CPT codes and amount
signRecord()    — Hospital or Lab Admin approves bill (verified by wallet address)
isApproved()    — Returns bool: true if both admins have signed, false otherwise

The contract was written independently with explicit require statements for input validation, NatSpec documentation on every function explaining the RCM context, and clean variable naming. It is based on the multi-signature approval pattern from the open source project below.

Tech Stack
Solidity ^0.8.0 — smart contract language
Ethereum — deployed on Remix VM (local Ethereum Virtual Machine)
Remix IDE — browser-based smart contract development and deployment
React.js — frontend web application (included in repository)
Web3.js — JavaScript library for blockchain interaction
MetaMask — browser wallet for transaction signing
Ganache — local Ethereum blockchain for development testing
Truffle — Ethereum development framework (configuration included)
Node.js + npm — package management and frontend build

Note: The React frontend is included in the repository. Smart contract functionality is fully working. Web3/MetaMask frontend integration is partially implemented — the contract was primarily demonstrated via Remix IDE during development.

Getting Started
Prerequisites
Node.js + npm
MetaMask browser extension
Ganache (local blockchain)
Remix IDE (browser-based — no install needed)
Run the Frontend
bash
cd Web-client
npm install
npm start

Opens at localhost:3000

Deploy the Smart Contract
Open Remix IDE
Load contracts/HealthCare.sol
Compile with Solidity ^0.8.0
Deploy to Remix VM or connect Ganache via MetaMask
Copy the deployed contract address into the Web3 provider config in the frontend
Open Source Foundation

This project is forked from Rishabh42/HealthCare-Insurance-Ethereum, originally built as a ConsenSys blockchain exercise.

What was added on top of the fork:

Smart contract rewritten with enhanced require validation statements and full NatSpec documentation
RCM industry framing — recontextualised from a generic exercise to a specific medical billing fraud prevention solution
Real CPT code test data drawn from professional RCM experience
Fraud pattern analysis — upcoding, duplicate billing, COVID-19 lab fraud connected to actual contract logic
Full project documentation connecting technical implementation to real-world RCM workflows
Developer

Built by Jude Elton as part of a BSc Computer Science degree (First Class Honours, University of East London, 2026). Informed by direct professional experience in healthcare Revenue Cycle Management across VOB, AR Collection, Arbitration, and QA departments.

GitHub · LinkedIn
