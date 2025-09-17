// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract ReverseString {
    function reverse(string memory str) external pure returns (string memory) {
        bytes memory strBytes = bytes(str);

        if (strBytes.length <= 1) {
            return str;
        }

        for (uint i; i < strBytes.length / 2; i++) {
            if (i == strBytes.length - 1 - i) {
                break;
            }

            bytes1 temp = strBytes[i];
            strBytes[i] = strBytes[strBytes.length - 1 - i];
            strBytes[strBytes.length - 1 - i] = temp;
        }

        return string(strBytes);
    }
}
