// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract RichestSays {
    address payable LastPayer;
    uint256 public NextValue = 0;
    uint8 public ShooterCounter = 0;

    address payable _owner;

    event ShootWon(string author, string message, uint256 value);
    event ShootDead(string author, string message, uint256 value);

    constructor() {
        _owner = payable(msg.sender);
        ShooterCounter = 0;
        NextValue = get_value(0);
    }

    function shoot_roulette() payable external {
        require(msg.value == NextValue);
        uint8 randValue = random(msg.sender, NextValue);

        if (ShooterCounter > 0){
            LastPayer.transfer(NextValue - (1 ether * 0.001));
        }

        if (randValue == 0) {
            NextValue = get_value(0);
            ShooterCounter = 0;
        } else {
            LastPayer = payable(msg.sender);
            ShooterCounter++;
            NextValue = get_value(ShooterCounter);
        }
    }

    function random(address payerAddress, uint256 value) private view returns (uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, payerAddress, value)))%100);
    }

    function get_value(uint8 count) public pure returns (uint256) {
        return (1 ether * 0.011) * (count + 1);
    }

    function cash_back() external payable {
        _owner.transfer(address(this).balance);
    }

    receive() external payable {
        _owner.transfer(msg.value);
    }

    fallback() external payable {
        _owner.transfer(msg.value);
    }
}