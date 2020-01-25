pragma solidity ^0.5.16;

import "./ERC721Interface.sol";

contract ERC721Token is ERC721 {
    address public owner;
    
   
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    mapping(address=> uint256) balances;
    mapping(address=>uint)  tokens;
    
    function balanceOf(address _owner) external view returns (uint256){
        require(balances[_owner]!= 0,"Error: Owner doesn't exist");
        return balances[_owner];
    }
    
    function ownerOf(uint256 _tokenId) external view returns (address){
        
    }
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    
    
}
