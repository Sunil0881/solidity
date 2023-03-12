//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
       



contract Portal{

    struct customer_from{
     string     user_address;     /*    user wallet address                      */
     string     f_network;        /*    from network                             */
     uint       f_networkid;      /*    from network ID                          */
     string     f_c_name;         /*    from coin name                           */
     uint       c_qty;            /*    coin quantity                            */
    }

    customer_from[] structarray1;
    function addtransaction(string memory User_address, string  memory F_network, uint F_networkid,  string memory F_c_name, uint C_qty) public {
        customer_from memory newcustomer_from =customer_from(User_address, F_network, F_networkid, F_c_name, C_qty);
        structarray1.push(newcustomer_from);
    } 
    function gettransaction(uint i) external view returns(string memory User_address, string  memory F_network, uint F_networkid,  string memory F_c_name, uint C_qty){
        customer_from storage customer = structarray1[i];
        return (customer.user_address, customer.f_network, customer.f_networkid, customer.f_c_name, customer.c_qty);
    }
}   
        
        