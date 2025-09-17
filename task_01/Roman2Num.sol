// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract Roman2Num {
    function roman2Num(string memory input) external pure returns (uint) {
        bytes memory roman = bytes(input);

        uint num;

        for (uint i; i < roman.length; i++) {
            uint current = getVal(roman[i]);
            if (i < roman.length - 1 && getVal(roman[i + 1]) > current) {
                // 如果当前不是最后一位，并且下一位比当前位数值更大，表示需要剪去当前位
                num -= current;
            } else {
                num += current;
            }
        }
    }

    function getVal(bytes1 b) private pure returns (uint) {
        if (b == "I") return 1;
        if (b == "V") return 5;
        if (b == "X") return 10;
        if (b == "L") return 50;
        if (b == "C") return 100;
        if (b == "D") return 500;
        if (b == "M") return 1000;
        revert("invalid roman");
    }
}
