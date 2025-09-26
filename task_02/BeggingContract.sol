// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

/**
任务目标
  使用 Solidity 编写一个合约，允许用户向合约地址发送以太币。
  记录每个捐赠者的地址和捐赠金额。
  允许合约所有者提取所有捐赠的资金。

任务步骤
  编写合约
    创建一个名为 BeggingContract 的合约。
    合约应包含以下功能：
      一个 mapping 来记录每个捐赠者的捐赠金额。
      一个 donate 函数，允许用户向合约发送以太币，并记录捐赠信息。
      一个 withdraw 函数，允许合约所有者提取所有资金。
      一个 getDonation 函数，允许查询某个地址的捐赠金额。
      使用 payable 修饰符和 address.transfer 实现支付和提款。
  部署合约
    在 Remix IDE 中编译合约。
    部署合约到 Goerli 或 Sepolia 测试网。
  测试合约
    使用 MetaMask 向合约发送以太币，测试 donate 功能。
    调用 withdraw 函数，测试合约所有者是否可以提取资金。
    调用 getDonation 函数，查询某个地址的捐赠金额。

任务要求
  合约代码：
    使用 mapping 记录捐赠者的地址和金额。
    使用 payable 修饰符实现 donate 和 withdraw 函数。
    使用 onlyOwner 修饰符限制 withdraw 函数只能由合约所有者调用。
  测试网部署：
    合约必须部署到 Goerli 或 Sepolia 测试网。
  功能测试：
    确保 donate、withdraw 和 getDonation 函数正常工作。

提交内容
  合约代码：
    提交 Solidity 合约文件（如 BeggingContract.sol）。
  合约地址：
    提交部署到测试网的合约地址。
  测试截图：
    提交在 Remix 或 Etherscan 上测试合约的截图。

额外挑战（可选）
  捐赠事件：
    添加 Donation 事件，记录每次捐赠的地址和金额。
  捐赠排行榜：
    实现一个功能，显示捐赠金额最多的前 3 个地址。
  时间限制：
    添加一个时间限制，只有在特定时间段内才能捐赠
 */

contract BeggingContract {
    mapping(address => uint256) private donations;
    address private owner;
    address[] private donors;

    uint256 public startTime;
    uint256 public endTime;

    event Donation(address indexed donor, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "no authorized");
        _;
    }

    constructor(uint256 _startTime, uint256 _endTime) {
        require(_endTime > _startTime, "time expired");
        owner = msg.sender;
        startTime = _startTime;
        endTime = _endTime;
    }

    // 捐赠
    function donate() external payable {
        require(
            block.timestamp >= startTime && block.timestamp <= endTime,
            "time expired or not start"
        );
        require(msg.value > 0, "donate value must greater than 0");

        if (donations[msg.sender] == 0) {
            donors.push(msg.sender);
        }
        donations[msg.sender] += msg.value;

        emit Donation(msg.sender, msg.value);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address donor) external view returns (uint256) {
        return donations[donor];
    }

    // 合约所有者提取所有资金
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "no balance");
        payable(owner).transfer(balance);
    }

    // 获取合约当前余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // 获取排行榜
    function getTop3()
        external
        view
        returns (address[3] memory topDonors, uint256[3] memory topAmounts)
    {
        uint256 donorCount = donors.length;

        for (uint256 i = 0; i < donorCount; i++) {
            address donor = donors[i];
            uint256 amount = donations[donor];

            // 检查是否进入前3名
            for (uint256 j = 0; j < 3; j++) {
                if (amount > topAmounts[j]) {
                    // 向后移动数据
                    for (uint256 k = 2; k > j; k--) {
                        topAmounts[k] = topAmounts[k - 1];
                        topDonors[k] = topDonors[k - 1];
                    }
                    topAmounts[j] = amount;
                    topDonors[j] = donor;
                    break;
                }
            }
        }
    }
}
