pragma solidity ^0.5.16;

import "./ERC721Interface.sol";

contract ERC721Token is ERC721 {
    address public owner;
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event UserCalldata(bytes);
    mapping(address=> uint256)                    tokens;
    mapping(uint256 => address)                   token_owner;
    mapping(address=>mapping(address=>uint256))   approved;
    uint256 token_count;
    constructor() public{
        owner=msg.sender;
        token_count=0;
    }
    
    function mint(address _reciepent) external payable onlyOwner{
        require(_reciepent!=address(0),"Error: Invalid address");
        token_count++;
        this.safeTransferFrom(owner,_reciepent,token_count);
        
    }
    
    function balanceOf(address _owner) external view returns (uint256){
        require(tokens[_owner]!= 0,"Error: Owner doesn't exist");
        return tokens[_owner];
    }
    
    function ownerOf(uint256 _tokenId) external view returns (address){
        return(token_owner[_tokenId]);
    }
   
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable onlySender(_from) {
        this.safeTransferFrom(_from,_to,_tokenId);
        emit UserCalldata(data);
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable onlySender(_from) {
        require(msg.sender==_from,"Error: Invalid invoker");
        require(_tokenId!=0,"Error: Invalid token Id");
        require(tokens[_from]==_tokenId,"Error: Invalid Owner");
        require(approved[_from][_to]==_tokenId,"Error: Transfer not approved");
        tokens[_from]=0;
        token_owner[_tokenId]=_to;
        tokens[_to]=_tokenId;
        emit Transfer(_from, _to, _tokenId);
    }
    
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable onlyOwner{
        this.safeTransferFrom(_from,_to,_tokenId);
    }
    function approve(address _approved, uint256 _tokenId) external payable onlySender(_approved){
        require(tokens[msg.sender]!=0,"Error: TokenId does not exist");
        require(token_owner[_tokenId]==msg.sender,"Error: Not a token owner");
        approved[msg.sender][_approved]= _tokenId;
        emit Approval(msg.sender, _approved, _tokenId);
    }
    
    function setApprovalForAll(address _operator, bool _approved) external onlyOwner {
        this.approve(_operator,tokens[_operator]);
        
    }
    function getApproved(uint256 _tokenId) external onlyOwner view  returns (address) {
        require(_tokenId !=0,"Error: Invalid tokenId");
        return token_owner[_tokenId];
    }
    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return (approved[_owner][_operator]!=0);
    }
    
    modifier onlyOwner{
        require(msg.sender==owner, "Error: Only owner authorised");
        _;
    }
    modifier onlySender(address _from){
        require(msg.sender==_from || msg.sender == owner,"Error: Invalid invoker");
        _;
    }
}
