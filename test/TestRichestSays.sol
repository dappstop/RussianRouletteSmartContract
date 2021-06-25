pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/RichestSays.sol";

contract TestRichestSays {
    // The address of the adoption contract to be tested
    RichestSays richestSays = RichestSays(DeployedAddresses.RichestSays());
    uint public initialBalance = 1 wei;

    function testSaySomethingTwice() public {
        richestSays.say_something.value(1)("abc");

        // uint a = 1;
        // uint b = 2;

        // Assert.equal(a, b, "worked");
    }

}