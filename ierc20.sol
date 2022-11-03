//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
//create an interface for the main contract
interface IERC20{
    //the total amount of token in the owner's wallet
    function totalSupply() external view returns(uint);
    //the total amount of token left in a wallet, irrespective of the owner
    function balanceOf(address account) external view returns(uint);
    //the owner of the wallet is transferring a certain amount of token to another address
    function transfer(address recipient, uint amount) external returns(bool);
    //The owner of the wallet is allowing another person to be able to spend from the wallet
    function allowance(address owner, address spender) external view returns(uint);
    //the amount the owner of the wallet is approving for another person to spend from the wallet
    function approve(address spender, uint amount) external returns (bool);
    /*this function allows the person that the owner approved to take money from his wallet, to be able to
    send money to another person*/
    function transferFrom(address sender, address recepient, uint amount) external returns (bool);

    //communicates with the frontend that an amount of token has been transfered into a wallet
    event Transfer(address indexed from, address indexed to, uint amount);
    //communicates with the frontend that an amount of token has been approved for a wallet to spend
    event Approval(address indexed owner, address indexed spender, uint amount);
}
