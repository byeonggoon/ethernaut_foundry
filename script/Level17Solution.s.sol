// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level17.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract RecoverySolution is Script {
    SimpleToken public simpleToken =
        SimpleToken(payable(0x8F31dD2aCF33234ad92E1945133836878ff942f3));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address lostcontract = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            address(0x951636ADcB3BFDE80fEB9aA2f71094Bb73CB1817),
                            bytes1(0x01)
                        )
                    )
                )
            )
        );
        console.log(lostcontract);

        // console.log(
        //     address(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1).balance
        // );
        // simpleToken.destroy(
        //     payable(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1)
        // );
        // console.log(
        //     address(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1).balance
        // );

        vm.stopBroadcast();
    }
}
