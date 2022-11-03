
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 //import the file containing the interfface to this new contract
import "ERC20-project/ierc20.sol";
 
 //create a new contract and inherit the interface of the imported file
contract ERC20 is IERC20{
    //create a state variable for the total supply of token contained in a wallet
    uint public override totalSupply;
    /*create a state variable for the balance of token contained in a wallet by mapping the wallet address and
    the amount in the wallet*/
    mapping(address => uint) public override balanceOf;
    /*create a state variable that allows another wallet spend from the owner's wallet by mapping the owner's wallet 
    address, the wallet address of the person allowed to spend the token and the amount in the other person's wallet*/
    mapping(address => mapping(address => uint)) public override allowance;
    //create a variable containing the name of the token
    string public name ="tech4dev";
    //create a variable containing the symbol of the token
    string public symbol ="T4D";
    //create a variable containing the number of decimals in the token
    uint public decimals = 18;
 
    //create a function that transfers token from the owner of the wallet to another wallet
    function transfer(address recipient, uint amount) external override returns(bool){
        //deduct the amount to be transfered from the total balance contained in the owner's address
        balanceOf[msg.sender] -= amount;
        //add the amount that was transfered from the owner of the wallet to the recipient's total balance 
        balanceOf[recipient] += amount; 

        //emit the transfer event that lets the frontend know that a certain amount of token has been transfered to a recipient
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    
    //create a function that approves a stipulated amount of token that can be spent from the owner's wallet by another person
    function approve(address spender, uint amount) external override returns(bool){
        //create a variable that allows the owner of the wallet to specify the amount of token that can be spent by another person
        allowance[msg.sender][spender] = amount;

        /*emit the approval event that lets the frontend know that a certain amount of token has been approved by 
        the owner of the wallet to be spent by another wallet*/
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    /*create a function that allows the person that the owner has approved to spend token to be able to send the token
    to another walllet*/
    function transferFrom(address sender, address recipient, uint amount) external override returns(bool){
        //deduct the amount of token the other person is spending from the owner's wallet
        allowance[sender][msg.sender] -= amount;
        //shows the amount of token left in the owner's wallet after the other person has sent a certain amount of token
        balanceOf[sender] -= amount;
        //add the amount of token sent to the balance of the recipient
        balanceOf[recipient] += amount;

        /*emit the transfer event that lets the frontend know that a certain amount of token has been transfered from
        the owner's wallet by the person the owner approved.*/
        emit Transfer(sender, recipient, amount);
        return true;
    }


    //create a function that adds a certain amount of token to the owner's wallet
    function mint(uint amount) public{
        //add the inputed amount of token to the balance of the owner of the wallet
        balanceOf[msg.sender] += amount;
        //increase the total supply of token by the amount of token inputed
        totalSupply += amount;
        //emit the transfer event that lets the frontend know that a certain amount of token has been transfered to the owner's wallet
        emit Transfer(address(0), msg.sender, amount);
    }

    //create a function that reduces the total supply of tokens in the owner's wallet
    function burn(uint amount) public {
        //reduce the inputed amount of token from the balance of the owner of the wallet
        balanceOf[msg.sender] -= amount;
        //reduce the toal supply of token by the amount of token inputed
        totalSupply -= amount;
        //emit the transfer event that lets the frontend know that a ceratain amount of token has been removed from the owner's wallet
        emit Transfer(msg.sender, address(0), amount);
    }
 
}