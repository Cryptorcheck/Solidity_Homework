// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract Voting {
    address public owner;
    mapping(address user => uint votes) public userVotes;
    mapping(address user => bool hasKey) private _keyMap;
    address[] private _keys;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "access defined");
        _;
    }

    // 投票给某个候选人
    function vote(address targetUser) external {
        require(msg.sender != targetUser, "don't vote for yourself");
        userVotes[targetUser] += 1;

        if (!_keyMap[targetUser]) {
            _keyMap[targetUser] = true;
            _keys.push(targetUser);
        }
    }

    // 获取得票数
    function getVotes(address targetUser) external view returns (uint votes) {
        votes = userVotes[targetUser];
    }

    // 重置得票数
    function resetVotes() external onlyOwner {
        for (uint i; i < _keys.length; i++) {
            delete userVotes[_keys[i]];
        }
    }
}
