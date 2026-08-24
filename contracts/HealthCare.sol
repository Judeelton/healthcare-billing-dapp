// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title HealthCare Billing Smart Contract
 * @author Judeelton
 * @notice This smart contract is designed to prevent fraudulent medical billing
 *         in the Revenue Cycle Management (RCM) industry.
 * @dev This contract implements a multi-signature approval system where both
 *      the Hospital Admin and Lab Admin must approve a medical bill before
 *      it can be claimed by the insurance company. This prevents any single
 *      party from fraudulently approving bills.
 *
 * Real World Problem Solved:
 * In the healthcare industry, fraudulent billing costs billions annually.
 * Bills can be tampered with, duplicated, or falsely approved by a single
 * corrupted employee. This smart contract solves this by requiring TWO
 * independent approvals stored immutably on the Ethereum blockchain.
 * Once recorded, no one can alter or delete the billing records.
 */

contract HealthCare {

    struct Record {
        string patientName;
        string billDetails;
        uint256 billAmount;
        address patient;
        bool hospitalApproved;
        bool labApproved;
        uint256 signatureCount;
    }

    mapping(uint256 => Record) public _records;
    uint256 public recordCount;
    address public hospitalAdmin;
    address public labAdmin;

    constructor(address _labAdmin) {
        hospitalAdmin = msg.sender;
        labAdmin = _labAdmin;
    }

    function newRecord(
        string memory _patientName,
        string memory _billDetails,
        uint256 _billAmount
    ) public {
        recordCount++;
        _records[recordCount] = Record({
            patientName: _patientName,
            billDetails: _billDetails,
            billAmount: _billAmount,
            patient: msg.sender,
            hospitalApproved: false,
            labApproved: false,
            signatureCount: 0
        });
    }

    function signRecord(uint256 _id) public {
        Record storage record = _records[_id];
        require(_id > 0 && _id <= recordCount, "Invalid record ID");

        if (msg.sender == hospitalAdmin) {
            require(!record.hospitalApproved, "Hospital has already approved this bill");
            record.hospitalApproved = true;
            record.signatureCount++;
        } else if (msg.sender == labAdmin) {
            require(!record.labApproved, "Lab has already approved this bill");
            record.labApproved = true;
            record.signatureCount++;
        }
    }

    function isApproved(uint256 _id) public view returns (bool) {
        return _records[_id].signatureCount >= 2;
    }
}
