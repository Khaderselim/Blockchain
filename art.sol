// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract art{
    function deposit() public payable {
        require(msg.value>0, "Deposit must be greater than 0.");
        balances[msg.sender] += msg.value;
    }
    mapping (address => uint256) public balances;
    
    address payable owner;
    constructor()  public   {
        owner = payable (msg.sender);
    }
    struct artwork{
        uint256 idtoken;
        address owner;
        string title;
        uint256 price;
        bool forSale;
    }

    mapping (string => uint256) public  artid;
    mapping (uint256 => artwork) public artinfo;

    function addart(uint256 _idtoken,string memory _title, uint256 _price) public {
        artwork memory newart =artwork(_idtoken,msg.sender,_title,_price,true);
        artid[_title] = _idtoken;
        artinfo[_idtoken] = newart;


        
    }

    function buyart(uint256 _idtoken) public {
        require(msg.sender!= owner,"owner can't buy the art");
        require(balances[msg.sender]>= artinfo[_idtoken].price,"Insufficient funds");
        require(artinfo[_idtoken].forSale==true,"Not for Sale");
        artinfo[_idtoken].owner = msg.sender;
        artinfo[_idtoken].forSale= false;
        balances[msg.sender]-=artinfo[_idtoken].price;
        balances[artinfo[_idtoken].owner]+=artinfo[_idtoken].price;
    }
}