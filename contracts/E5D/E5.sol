//SPDX-License-Identifier: Unlicense
// Copyright (c) 2022 Bry Onyoni
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
pragma solidity 0.8.4;

import "./E52.sol"; /* import "./E52.sol"; */
import "./E3.sol"; /* import "./E5Data/E5HelperFunctions.sol"; */
import "./E32.sol"; /* import "./E5Data/E5HelperFunctions2.sol"; */
import "./E33.sol"; /* import "./E5Data/E5HelperFunctions2.sol"; */

import "../F5D/F5.sol"; /* import "../SubscriptionData/SubscriptionData.sol"; */
import "../G5D/G5.sol"; /* import "./ContractsData/ContractsData.sol"; */
import "../G5D/G52.sol"; /* import "./ContractsData/ContractsData2.sol"; */

import "../H5D/H5.sol"; /* import "./TokensData/TokensData.sol"; */
import "../H5D/H52.sol"; /* import "./TokensData/TokensData2.sol"; */

contract E5 {
    /* the main contract for all E5's */
    
    event e1/* MakeObject */(uint256 indexed p1/* object_id */, uint256 indexed p2/* object_type */, uint256 indexed p3/* sender_account_id */, uint256 p4/* timestamp */, uint256 p5/* block_number */);
    /* event used for recording when a new object is created in E5 */

    event e2/* Withdraw */( uint256 indexed p1/* sender_account_id */, address indexed p2/* sender_address */, address indexed p3/* receiver_address */, uint256 p4/* transaction_id */, uint256 p5/* amount */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event used for recording when ether is withdrawn from a specified accounts withdraw balance */
    
    event e3/* PendingWithdraw */( uint256 indexed p1/* receiver_account_id */, uint256 p2/* amount_added */, uint256 p3/* timestamp */, uint256 p4/* block_number */ );
    /* event used for recording when a specified recipients pending withdraw balance is updated */

    event e4/* Transaction */( uint256 indexed p1/* sender_account_id */, address indexed p2/* sender_address */, uint256 p3/* temp_transaction_id */, uint256 p4/* transaction_stack_size */, uint256 p5/* estimated_gas_consumed */, uint256 p6/* msg_value */, uint256 p7/* gas_price */, uint256 p8/* timestamp */, uint256 p9/* block_number */, address p10/* coinbase_miner */, uint256 p11/* block_difficulty */ );
    /* event used for recording when a new transaction is processed in E5 */

    event e5/* Channel */( uint256 indexed p1/* channel_id */, string indexed p2/* identifier */, uint256 p3/* block_number */, uint256 p4/* block_timestamp */ );
    /* event used for recording when a new channel is created */

    event e6/* MakeAccount */(uint256 indexed p1/* creator_account */, address indexed p2/* new_account_address */, uint256 indexed p3/* new_account_id */, uint256 p4/* context */, uint256 p5/* timestamp */, uint256 p6/* block_number */);
    /* event used for recording when a new account is created for a specified address */

    event e7/* record_boot_addresses */(address indexed p1/* main_address */, address indexed p2/* sender */, uint256 p3/* timestamp */, uint256 p4/* block_number */, address[7] p5/* all_addresses */);
    /* event used for recording the addresses associated with E5 and its corresponding sub-contracts */

    uint256 private gv1/* id */ = 1000;
    /* global variable keeping track of the new ids being created */

    bool private gv2/* booted */ = false;
    /* global variable that records if E5 has been booted */

    address private immutable gv3/* deploy_address */ = msg.sender;
    /* global variable that records the deployer of E5 */

    mapping(address => bool) private gv4/* lock_addresses_mapping */;
    /* global variable thats used to restrict E5's access */

    uint256 private gv5/* lock */ = 1;
    /* global variable thats used to lock and unlock e */

    E33.NumData private gv6/* num_data */;
    /* data for this contract, whose structure is defined in the E33 library */

    E52 private gv7/* e52 */;
    /* global variable that points to the E52 contract*/

    G5 private gv8/* contractsData */;
    /* global variable that points to the G5 contract*/

    G52 private gv9/* contractsData2 */;
    /* global variable that points to the G52 */

    F5 private gv10/* subscriptionData */;
    /* global variable that points to the F5 contract */

    H5 private gv11/* tokensData */;
    /* global variable that points to the H5 contract */

    H52 private gv12/* tokensData2 */;
    /* global variable that points to the H52 contract */

    constructor() {}

    /* auth */
    modifier f150(address v1/* caller */) {
        /* ensures the sender of a given action is permitted */

        require(gv4/* lock_addresses_mapping */[v1/* caller */] == true);
        /* ensures the caller of a given function is valid */

        _;
    }//-----TEST_OK-----

    /* boot */
    function f157(
        address[7] calldata p1/* boot_addresses */,
        uint256[][][] calldata p2/* boot_data */,
        uint256[][] calldata p3/* boot_id_data_type_data */,
        string[][] calldata p4/* boot_object_metadata */,
        uint256[] calldata p5/* new_main_contract_config */
    ) external {
        /* boots E5 for the first and last time */
        /* boot_addresses: [0]mainAddress , [1]E52Address , [2]SubscriptionDataAddress , [3]contractsDataAddress, [4]contractsData2Address, [5]tokensDataAddress, [6]tokensData2Address */

        require(msg.sender == gv3/* deploy_address */ && !gv2/* booted */);
        /* ensure the sender of the boot action is the deploy address and the E5 is already booted */

        gv2/* booted */ = true;
        /* set the boot value to true */

        for (uint256 t = 0; t < p1/* boot_addresses */.length; t++) {
            /* for each address specified in the boot addresses array */

            gv4/* lock_addresses_mapping */[p1/* boot_addresses */[t]] = true;
            /* set the lock value to true to ensure only each address can call functions in E5 */
        }
        gv7/* e52 */ = E52(p1/* boot_addresses */[ 1 /* E52Address */ ]);
        /* initialize a storage object pointing to E52 */

        gv10/* subscriptionData */ = F5(p1/* boot_addresses */[ 2 /* SubscriptionDataAddress */ ]);
        /* initialize a storage object pointing to F5 */

        gv8/* contractsData */ = G5(p1/* boot_addresses */[ 3 /* contractsDataAddress */ ]);
        /* initialize a storage object pointing to G5 */

        gv9/* contractsData2 */ = G52(p1/* boot_addresses */[ 4 /* contractsData2Address */ ]);
        /* initialize a storage object pointing to G52 */

        gv11/* tokensData */ = H5(p1/* boot_addresses */[ 5 /* tokensDataAddress */ ]);
        /* initialize a storage object pointing to H5 */

        gv12/* tokensData2 */ = H52(p1/* boot_addresses */[ 6 /* tokensData2Address */ ]);
        /* initialize a storage object pointing to H52 */

        gv10/* subscriptionData */.f159/* boot */(p1/* boot_addresses */, p2/* boot_data */, p3/* boot_id_data_type_data */, p4/* boot_object_metadata */, p5/* new_main_contract_config */);
        /* call the boot data action in the F5 subscriptions contract */

        E33.f93/* update_main_contract_limit_data */(p5/* new_main_contract_config */, gv6/* num_data */);
        /* set the main contract data configuration */
    }

    /* record_addresses */
    function f2023(address[7] calldata p1/* boot_addresses */) external {
        /* records the boot addresses for each E5 contract */

        require(msg.sender == gv3/* deploy_address */);
        /* ensure the sender of the transaction is the address that deployed E5 */

        emit e7/* record_boot_addresses */(address(this), msg.sender, block.timestamp, block.number, p1/* boot_addresses */);
        /* emit the seven addresses corresponding to each smart contract in E5 */
    }
    

    /* run_transactions */
    uint256 g = 1;
    function e(
        uint256[2] calldata p1/* t_limits */,
        address[][] calldata p2/* _adds */,
        uint256[][][] calldata p3/* _ints */,
        string[][][] calldata p4/* _strs */
    ) external payable {
        /* starting point for all transactions involving modifying the state of E5 */

        uint256 v1/* gas */ = gasleft();
        /* record the remaining gas for the given transaction */

        uint256 v2/* temp_transaction_id */ = f143/* transaction_start */(p1/* t_limits */);
        /* lock e and record a transaction id for the specified transaction in focus */

        E3.TD/* TransactionData */ memory v3/* tx_data */ = f167/* set_up_transaction_data_struct */( p3/* _ints */, p4/* _strs */, p2/* _adds */, v1/* gas */ );
        /* sets up a transaction data struct for the given transaction  */

        g = 1;
        for (uint256 t = 0; t < p3/* _ints */.length; t++) {
            /* for each transaction stack specified in the ints data array */
            v3/* tx_data */.t = t;
            /* record the transaction in focus */

            if(t != 0){
                /* if it is not the first transaction in focus */
                v3/* tx_data */.sv4/* vals */ = p3/* _ints */[t];
                /* record the stack in focus from the ints data array */
                
                if(p2/* _adds */.length > t){
                    /* if addresses have been specified for the given transaction stack in focus */

                    v3/* tx_data */.sv5/* adds */ = p2/* _adds */[t];
                    /* set the address data array in focus */
                }
                
                if(p4/* _strs */.length > t){
                    /* if strings have been specified for the given transaction stack in focus */

                    v3/* tx_data */.sv6/* strs */ = p4/* _strs */[t];
                    /* set the strings data array in focus */
                }
            }

            if ( p3/* _ints */[t][0][0] == 10000 /* entity contructor */ ) {
                /* if the action involves creating a new entity */

                uint256 v4/* gas_start */ = gasleft();

                (v3/* tx_data */.sv3/* temp_transaction_data */[t]) = f169/* create_entity */(v3/* tx_data */);
                /* starts the create entity function and records the return value in the temp transaction data array in the data struct */

                g += (v4/* gas_start */ - gasleft());
            } else {
                uint256 v4/* gas_start */ = gasleft();
                v3/* tx_data */.sv8/* tx_value_available */ = f178/* execute_sub_contract_work */(v3/* tx_data */);
                /* starts the token transaction or moderator action function */

                g += (v4/* gas_start */ - gasleft());
            }
        }

        gv6/* num_data */.int_int_int[v3/* tx_data */.sv1/* user_acc_id */][ 1 /* data */ ][ 3 /* transaction_count */ ] += 1;
        /* increment the number of transactions for the sender's account */

        f144/* transaction_end */();
        /* ends the transaction */

        emit e4/* Transaction */( v3/* tx_data */.sv1/* user_acc_id */, msg.sender, v2/* temp_transaction_id */, p3/* _ints */.length, (v1/* gas */ - gasleft()), msg.value, tx.gasprice, block.timestamp, block.number, block.coinbase, 0);
        /* emits the transaction's data */
        
    }

    /* get_gas_consumed */
    function f5300g() public view returns (uint256){
        return g;
    }


    /* withdraw */
    function f145(address p1/* withdraw_target */, uint256[2] calldata p2/* t_limits */) external {
        /* called externally when an account is withdrawing ether to a specified target from their withdraw balance */

        require(gasleft() <= 65000);
        /* ensure a valid gaslimit was specified for the transaction */

        uint256 v4/* temp_transaction_id */ = f143/* transaction_start */(p2/* t_limits */);
        /* locks e and records the transaction id */

        uint256 v1/* sender_acc */ = gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ][msg.sender];
        /* records the sender addresses account from storage */

        uint256 v2/* amount */ = gv6/* num_data */.pending_withdrawals[v1/* sender_acc */];
        /* records the pending withdraw amount stored for the specified account */

        gv6/* num_data */.pending_withdrawals[v1/* sender_acc */] = 0;
        /* sets the pending withdraw value to zero for the sender account */

        (bool v3/* sent */, ) = payable(p1/* withdraw_target */).call{value: v2/* amount */}(""); 
        /*  send them their wei(no pun intended) */

        require(v3/* sent */, ""/* failed to send requested wei */);
        /* ensures the ether has been sent to the specified withdraw target */

        f144/* transaction_end */();
        /* unlock e */

        emit e2/* Withdraw */(v1/* sender_acc */, msg.sender, p1/* withdraw_target */, v4/* temp_transaction_id */ , v2/* amount */, block.timestamp, block.number);
        /* emit a withdraw action with the specified withdraw data such as the sender account, withdraw target and amount */
    }//-----TEST_OK-----
    



    
    /* transaction_start */
    function f143(uint256[2] calldata p1/* t_limits */) private returns (uint256) {
        /* called when a transaction is starting */

        require(gv2/* booted */ && gv5/* lock */ == 1/* unlocked */);
        /* ensures e is unlocked and booted */

        gv5/* lock */ = 2/* locked */;
        /* sets e as locked */

        require( block.number <= p1/* t_limits */[ 0 /* block_limit */ ] && block.timestamp <= p1/* t_limits */[ 1 /* block_timestamp */ ] );
        /* ensures the transaction is being processed in the specified time and block limit */
    
        return f146/* make_id */();
        /* returns a new id for the transaction */
    }//-----TEST_OK-----

    /* transaction_end */
    function f144() private {
        /* called when a transaction has ended */

        gv5/* lock */ = 1/* unlocked */;
        /* sets e as unlocked */
    }//-----TEST_OK-----

    /* make_id */
    function f146() private returns (uint256) {
        /* creates a new id for a specified new object */

        gv1/* id */++;
        /* increment the id value by one */

        return gv1/* id */;
        /* return the new value */
    }//-----TEST_OK-----


    


    /* set_up_transaction_data_struct */
    function f167(
        uint256[][][] calldata p1/* _ints */,
        string[][][] calldata p2/* _strs */,
        address[][] calldata p3/* _adds */,
        uint256 p4/* tx_gas */
    ) private returns (E3.TD/* TransactionData */ memory v1/* tx_data */) {
        /* sets up the transaction data struct with the specified arguments from the call data */

        ( uint256 v2/* user_acc_id */, bool v3/* can_sender_vote_in_main_contract */, uint256[][2] memory v4/* temp_transaction_data|route_data */ ) = f168/* account_transaction_check */(p4/* tx_gas */, p1/* _ints */); 
        /* runs the account transaction checkers to ensure sender is sending a transaction in a valid time */

        mapping(uint256 => uint256) storage v5/* sender_data */ = gv6/* num_data */.int_int_int[ v2/* user_acc_id */ ][ 1 /* data */ ];
        /* fetches the senders data such as the number of transactions made with e and the number of entered contracts */

        address[] memory v6/* first_addresses */ = p3/* _adds */.length == 0 ? new address[](0): p3/* _adds */[0];
        /* initialize an empty address array if no addresses have been specified in the argument calldata */

        string[][] memory v7/* first_strings */ = p2/* _strs */.length == 0 ? new string[][](0): p2/* _strs */[0];
        /* initialize an empty two dimentional string array if no strings have been specified in the argument calldata */

        v1/* tx_data */ = E3.TD/* TransactionData */( v2/* user_acc_id */, v3/* can_sender_vote_in_main_contract */, v4/* temp_transaction_data_group */[0/* temp_transaction_data */], p1/* _ints */[0], v6/* first_addresses */, v7/* first_strings */, 0, /* t */ 0, /* new_obj_id */ msg.value, [ v5/* sender_data */[ 3 /* transaction_count */ ], v5/* sender_data */[ 4 /* entered_contracts */ ] ], false , v4/* temp_transaction_data_group */[1/* route_data */]);
        /* creates a new transaction data struct with the specified data for the first transaction in focus */

        require(p1/* _ints */.length != 0);
        /* ensure the sender has sent at least one transaction */
    }

    /* account_transaction_check */
    function f168(uint256 p1/* tx_gas */, uint256[][][] calldata p2/* vals */) 
    private returns (uint256 v1/* user_account_id */, bool v2/* can_sender_vote_in_main_contract */, uint256[][2] memory v3/* temp_transaction_data|route_data */) {
        /* checks to ensure the run specified by the user is valid */
        uint i = gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ][msg.sender] == 0 ? f146/* make_id */() : 0;
        /* creates a new id for the sender if they have no account */

        (v1/* user_account_id */, v2/* can_sender_vote_in_main_contract */, v3/* temp_transaction_data|route_data */) = E33.f95/* account_transaction_check */(p1/* tx_gas */, gv6/* num_data */, i, p2/* vals */, gv1/* id */);
        /* calls the account transaction checker function in the E33 helper library */
    }

    //
    //
    //
    //
    //
    //
    // ------------------------10000 : ENTITY CREATION WORK-------------------------------
    /* create_entity */
    function f169(E3.TD/* TransactionData */ memory p1/* tx_data */) private returns ( uint256 v2/* new_temp_transaction_data_value */) {
        /* initial actions involving creating a new object in E5 */

        p1/* tx_data */.sv7/* new_obj_id */ = f146/* make_id */();
        /* creates a new id for the specified object */

        gv7/* e52 */.f171/* record_obj_type_and_creator */(p1/* tx_data */.sv4/* vals */[0][ 9 /* <9>object_type */ ], p1/* tx_data */.sv1/* user_acc_id */,  p1/* tx_data */.sv7/* new_obj_id */);
        /* records the author and object id and type in the E52 contract */

        v2/* new_temp_transaction_data_value */ = f170/* start_make_object */(p1/* tx_data */);
        /* calls the start make object function specified below */
    }

    /* start_make_object */
    function f170(E3.TD/* TransactionData */ memory p1/* tx_data */) private returns (uint256 v2/* new_temp_transaction_data_value */){
        /* function handles initializing the creation of a new object */
        uint256 v1/* object_type */ = p1/* tx_data */.sv4/* vals */[0][ 9 /* <9>object_type */ ];
        /* record the object type being created */

        v2/* new_temp_transaction_data_value */ = p1/* tx_data */.sv3/* temp_transaction_data */[p1/* tx_data */.t];
        /* record a default temporary transaction data value as the value stored in the data struct */

        E32.f15/* f15 check_if_main_contract_votable_required */(v1/* object_type */, p1/* tx_data */.sv2/* can_sender_vote_in_main_contract */);
        /* ensures the sender can vote in the main contract if the specified object is a post object */

        if ( v1/* object_type */ == 29 /* 29(account_obj_id) */ ) {
            /* if the action is a create account action */

            v2/* new_temp_transaction_data_value */ = f225/* make_new_account */(p1/* tx_data */);
            /* calls the make account function and re-records the new temporary transaction data value as the return account id from the function's returnd data */
        } else {
            /* if the action is to create a contract, proposal, token, subscription or channel */
            if ( v1/* object_type */ == 30 || /* contract_obj */ v1/* object_type */ == 32 /* consensus_request */ ) {
                /* if the action is to create a new contract or proposal object */
                gv8/* contractsData */.f174/* make_contract_or_consensus_request */(p1/* tx_data */);
                /* send the create action to the G5 contract */
            } 
            else if ( v1/* object_type */ == 31 /* (type token_exchange) */ ) {
                /* if the action is to create a token object */
                gv11/* tokensData */.f176/* make_token_exchange */(p1/* tx_data */);
                /* send the create token action to the H5 contract */
            }
            else if ( v1/* object_type */ == 33 /* 33(subscription_object) */ ) {
                /* if the action is to create a new subscription object */
                gv10/* subscriptionData */.f172/* make_subscription_object */(p1/* tx_data */);
                /* send the create subscription action to the F5 contract */
            } 
            else if ( v1/* object_type */ == 36 /* 36(type-channel-target) */ ) {
                /* if the action is to create a new channel */
                
                emit e5/* Channel */( p1/* tx_data */.sv7/* new_obj_id */, p1/* tx_data */.sv6/* strs */[ 0 /* target_string_array_pos */ ][0], block.number, block.timestamp );
                /* emit an event with the corresponding new channels information stored in the data struct */
            }
        }
        emit e1/* MakeObject */(p1/* tx_data */.sv7/* new_obj_id */, v1/* object_type */, p1/* tx_data */.sv1/* user_acc_id */, block.timestamp, block.number);
        /* emit an event to record the new object's creation */

    }

    /* make_new_account */
    function f225(E3.TD/* TransactionData */ memory p1/* tx_data */) private returns (uint256) {
        /* used for creating new accounts for a specified address */
        address v1/* new_address */ = p1/* tx_data */.sv5/* adds */[0];
        /* get the new address to create an account for */

        mapping(address => uint256) storage v2/* acc_obj_id_add_int */ = gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ];
        /* initialize a storage mapping that points to the specified addresses corresponding account if any exists */
        
        if (v2/* acc_obj_id_add_int */[v1/* new_address */] == 0) {
            /* if an account id does not exist for the specified address */

            gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ][v1/* new_address */] = p1/* tx_data */.sv7/* new_obj_id */;
            /* set the new id for the specific address as the new object id value stored in the transaction data struct */
            
            uint256 v3/* context */ = p1/* tx_data */.sv4/* vals */[0][3/* <3>context */];
            /* record the context of the invite, could be the account that invited the given address */
            
            emit e6/* MakeAccount */(p1/* tx_data */.sv1/* user_acc_id */, v1/* new_address */, p1/* tx_data */.sv7/* new_obj_id */, v3/* context */, block.timestamp, block.number);
            /* emit a make account action with the specific data corresponding to the creation event such as the context, account id and address */
        } else {
            /* if an account id exists for the specified address */
            if ( p1/* tx_data */.sv4/* vals */[0][ 5 /* <5>fail_if_duplicate_exists(1 if true) */ ] == 1 ) {
                /* if the sender specified that the transaction should revert if an account exists */
                revert("account already exists for the specified address being created");
                /* revert the transaction */
            }
            
        }
        return v2/* acc_obj_id_add_int */[v1/* new_address */];
        /* return the new address's account recorded */
    }
    
    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* update_main_contract_limit_data */
    function f206(uint256[] calldata p1/* new_main_contract_config */) external f150(msg.sender) {
        /* used to update the main contract data stored in the E5 contract */

        E33.f93/* update_main_contract_limit_data */(p1/* new_main_contract_config */, gv6/* num_data */);
        /* calls the update main contract data function in the E33 helper library */

        gv7/* e52 */.f94/* update_main_contract_limit_data */(p1/* new_main_contract_config */);
        /* calls the update main contract data function in the E52 contract */
    }

    //
    //
    //
    //
    //
    //
    // ------------------------30000 : SUB-CONTRACT TRANSACTION WORK-------------------------------
    /* execute_sub_contract_work */
    function f178(E3.TD/* TransactionData */ memory p1/* tx_data */) private returns (uint256 v5/* new_tx_value_available */){
        /* responsible for routing all the token transaction or moderator work actions to the other smart contracts of E5 */
        uint256 v1/* route */ = p1/* tx_data */.sv11/* route_data */[p1/* tx_data */.t];
        /* record the route stored and calculated from the action specified in the given transaction stack */

        v5/* new_tx_value_available */ = p1/* tx_data */.sv8/* tx_value_available */;
        /* record a default return balance value in ether as the value stored in the data struct */

        if(v1/* route */ == 552/* E52_transaction */){
            /* if the action is a E52 action, or a mod action */

            gv7/* e52 */.f217/* execute_mod_work */(p1/* tx_data */);
            /* send the transaction to E52 contract */
        }
        else if(v1/* route */ == 65/* Subscription_transaction */){
            /* if the action involves a subscription object */

            gv10/* subscriptionData */.f197/* run_f5_work */(p1/* tx_data */);
            /* send the transaction to F5 contract */
        }
        else if(v1/* route */ == 75/* Contracts_transaction */){
            uint256 v6/* action */ = p1/* tx_data */.sv4/* vals */[0][1/* action */];
            /* if the action is a contract action, involving G5 */

            if(v6/* action */ == 5/* <5>submit_consensus_request */){
                /* if the action is to submit a consensus request action */

                (uint256[] memory v2/* targets */, uint256[][] memory v3/* payer_accounts */, uint256[][][2] memory v4/* target_bounty_exchanges_depth-data */) = E3.f29/* get_submit_consensus_data */(p1/* tx_data */);
                /* get the transaction data such as the proposal targets, payer accounts(used while submitting proposals for collecting subscription payments) and bounty data for collecting bounty*/

                gv8/* contractsData */.f200/* execute_submit_consensus_request */(v2/* targets */, p1/* tx_data */.sv1/* user_acc_id */, v3/* payer_accounts */, v4/* target_bounty_exchanges_depth-data */);
                /* send the transaction to G5 with the specified data arguments */
            }
            else{
                /* if the action is a modify proposal or contract action in G5 */
                uint256[][5] memory v2/* target_id_data */ = E3.f21/* get_primary_secondary_target_data */(p1/* tx_data */);
                /* get the target data for the specified transaction */
                
                gv8/* contractsData */.f238/* execute_modify_proposals_or_contracts */(v2/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */, v6/* action */);
                /* send the data to G5 to modify the specified targets */
            }
        }
        else if(v1/* route */ == 752/* Contracts2_transaction */){
            /* if the action involves the G52 contract */

            uint256 v3/* entered_contracts */ = 0;
            /* set and record a default number of entered contracts */

            (v3/* entered_contracts */) = gv9/* contractsData2 */.f189/* run_contract_transactions */(p1/* tx_data */);
            /* send the action to the G52 contract and reset the entered contracts value as the return value */

            gv6/* num_data */.int_int_int[p1/* tx_data */.sv1/* user_acc_id */][ 1 /* data */ ][ 4 /* entered_contracts */ ] += v3/* entered_contracts */;
            /* record the new number of entered contracts for teh specified sender account */
        }
        else if(v1/* route */ == 85/* Tokens_transaction */){
            /* if the action involves the H5 tokens contract */
            uint256[3] memory v4/* buy_sell_data */ = gv11/* tokensData */.f179/* run_token_transaction */(p1/* tx_data */);
            /* send the transaction to H5 and record the return data */

            v5/* new_tx_value_available */ = v4/* buy_sell_data */[2/* _msg_value */];
            /* record the new transaction ether value, if used by the specified transaction in the transaction stack in focus */

            if(v4/* buy_sell_data */[0/* external_amount */] != 0){
                /* if external amount of ether exists */

                f141/* update_external_amount */(v4/* buy_sell_data */);
                /* call the update external amount value with the specified arguments */
            }
        }
        else if(v1/* route */ == 852/* Tokens2_transaction */){
            /* if the actioin involves the second H52 tokens contract */

            gv12/* tokensData2 */.f185/* run_h52_work */(p1/* tx_data */);
            /* send the transaction to the H52 contract with the specified argument */
        }
    }

    /* update_external_amount */
    function f141(uint256[3] memory p1/* buy_sell_data */) private {
        /* updates the pending withdraw data after a sell end action has occured  */

        // require(gv6/* num_data */.pending_withdrawals[ p1/* buy_sell_data */[1/* receiver_acc_id */] ] == 0);
        /* require the receiver of the sell order has no existing pending withdraw balance */

        gv6/* num_data */.pending_withdrawals[ p1/* buy_sell_data */[1/* receiver_acc_id */] ] = p1/* buy_sell_data */[0/* external_amount */];
        /* set the amount of ether for the receiver of the sell order */

        emit e3/* PendingWithdraw */(p1/* buy_sell_data */[1/* receiver_acc_id */], p1/* buy_sell_data */[0/* external_amount */], block.timestamp, block.number);
        /* emit a pending withdraw event for the receiver account and the amount of ether */
    }//-----TEST_OK-----


    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------

    /* get_balance | get_block_timestamp | get_block_number | gas_limit | difficulty */
    function f147(uint256 v1/* action */) public view returns(uint256){
        /* returns the basic blockchain data available to e such as the timestamp and block number */
        /* [1] = get_balance | [2] = get_block_timestamp | [3] = get_block_number | [4] = gas_limit | [5] = difficulty */
        
        if(v1/* action */ == 1){
            return address(this).balance;
        }
        else if(v1/* action */ == 2){
            return block.timestamp;
        }
        else if(v1/* action */ == 3){
            return block.number;
        }
        else if(v1/* action */ == 4){
            return block.gaslimit;
        }
        else if(v1/* action */ == 5){
            return block.difficulty;
        }
        else{
            return gv1/* id */;
        }
    }


    /* pending_withdraw_balance & get_accounts */
    function f167(uint256[] memory p1/* _ids */, address[] memory p2/* addresses */, uint256 p3/* action */) public view returns(uint256[] memory){
        /* returns the pending withdraw balance for a given set of accounts, or the account ids associated with a given set of addresses */
        /* <1>pending_withdraw_balance, <2>get_accounts, */
        return E33.f167/* get_all */(p1/* _ids */, p2/* addresses */, p3/* action */, gv6/* num_data */);
    }//-----TEST_OK-----

    /* get_address */
    function f289(uint256 p1/* account_id */) external view returns(address){
        /* returns the address corresponding to the account id specified */
        return gv6/* num_data */.int_add[ 10 /* accounts_obj_id */ ][p1/* account_id */];
    }

    /* get_last_transaction_block & last_transaction_time & entered_contracts_count & transaction_count_data && */
    function f287(uint256[] calldata p1/* accounts */) 
    public view returns (uint256[4][] memory v1/* data */){
        /* gets the basic transaction data for a given set of accounts such as the last time they sent a transaction to e, the number of entered contracts and the total number of transactions theyve made with e */
        return E33.f287/* get_last_transaction_block & last_transaction_time & entered_contracts_count & transaction_count_data */(p1/* accounts */, gv6/* num_data */);
    }

    /* calculate_max_consumable_gas */
    function f280(uint256[] calldata p1/* gas_prices */)
    public view returns (uint256[] memory v1/* consumable_gas_limits */){
        /* calculates and returns the amount of gas that can be consumed in a given run given a specified set of gas prices */
        return E33.f280/* calculate_max_consumable_gas */(p1/* gas_prices */, gv6/* num_data */);
    }


    //
    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
    // function f141e(uint256[3] memory p1/* buy_sell_data */) public {
    //     f141(p1/* buy_sell_data */);
    // }

    /* set_withdrawal */
    // function f1402(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv6/* num_data */.pending_withdrawals[ p1[t][0]/* _ids */ ] = p1/* _ids */[t][1];
    //     }
    // }

    /* delete_withdrawal */
    // function f1403(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv6/* num_data */.pending_withdrawals[ p1/* _ids */[t][0] ] = 0;
    //     }
    // }


    /* t_transaction_start */
    // function f1432(uint256[2] calldata p1/* t_limits */) public returns (uint256) {
    //     return f143(p1);
    // }

    /* t_transaction_end */
    // function f1442() public {
    //     gv5/* lock */ = 1/* unlocked */;
    // }

    /* t_get_id */
    // function f1433() public view returns(uint256){
    //     return gv1/* id */;
    // }

    /* make_id_test */
    // function f1462() public {
    //     f146/* make_id */();
    // }

    /* t_set_booted */
    // function f1434(bool p1) public {
    //     gv2/* booted */ = p1;
    // }

    /* t_get_locked */
    // function f1435() public view returns(uint256){
    //     return gv5/* lock */;
    // }

    /* receive_ether */
    // function f18e() external payable {}
    

    /* set_address account */
    // function f1404(address p1/* address_account */, uint256 p2/* account */) public {
    //     gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ][ p1 /* address_account */ ] = p2/* account */;
    // }

    /* delete_address account */
    // function f1405(address p1/* address_account */) public {
    //     gv6/* num_data */.add_int[ 10 /* accounts_obj_id */ ][ p1 /* address_account */ ] = 0;
    // }

     /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv4/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }


    // function func() external f150(msg.sender) {}


    /* get_booted */
    // function f1572() external view returns (bool){
    //     return gv2/* booted */;
    // }

    /* get_boot_data */
    // function f1573( address[7] calldata p1/* boot_addresses */ ) external view returns (uint256[7] memory v1/* data */){
    //     for (uint256 t = 0; t < p1/* boot_addresses */.length; t++) {
    //         if(gv4/* lock_addresses_mapping */[p1/* boot_addresses */[t]]){
    //             v1/* data */[t] = 1;
    //         }else{
    //             v1/* data */[t] = 0;
    //         }
    //     }
    // }

    /* read_data */
    // function f1574() public view returns(uint256[] memory v2/* data */){
    //     v2/* data */ = new uint256[](9);
    //     uint256[9] memory v1/* pos_used */ = [ uint256(11), 12, 13, 14, 16, 19, 24, 25, 26 ];
    //     for (uint256 t = 0; t < v1/* pos_used */.length; t++) { 
    //         v2/* data */[t] = gv6/* num_data */.num[ 2 /* main_contract_obj_id */ ][1][v1[t]];
    //     }
    // }


    /* set_link_requirements */
    // function f2232() public {
    //     mapping(uint256 => uint256) storage v1/* target_data */ = gv6/* num_data */.int_int_int[1002][1 /* data */];
    //     v1/* target_data */[ 3 /* transaction_count */ ] = 50;
    //     v1/* target_data */[ 4 /* entered_contracts */ ] = 50;
    // }

    /* get_gas_consumed */
    // function f5300g() external view returns (uint256){
    //     return g;
    // }

}

   