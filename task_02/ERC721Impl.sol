// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract ERC721Impl is IERC721 {
    function supportsInterface(
        bytes4 interfaceId
    ) external view returns (bool) {}

    function balanceOf(address owner) external view returns (uint256 balance) {}

    function ownerOf(uint256 tokenId) external view returns (address owner) {}

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external {}

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {}

    function transferFrom(address from, address to, uint256 tokenId) external {}

    function approve(address to, uint256 tokenId) external {}

    function setApprovalForAll(address operator, bool approved) external {}

    function getApproved(
        uint256 tokenId
    ) external view returns (address operator) {}

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool) {}
}
