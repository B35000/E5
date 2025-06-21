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

import "./E3.sol"; /* import "./E5Data/E5HelperFunctions.sol"; */
import "./E34.sol"; /* import "./E5Data/E5HelperFunctions4.sol"; */

import "../F5D/F5.sol"; /* import "../SubscriptionData/SubscriptionData.sol"; */

import "../G5D/G5.sol"; /* import "./ContractsData/ContractsData.sol"; */
import "../G5D/G52.sol"; /* import "./ContractsData/ContractsData2.sol"; */

import "../H5D/H5.sol"; /* import "./TokensData/TokensData.sol"; */
import "../H5D/H52.sol"; /* import "./TokensData/TokensData2.sol"; */


contract E52 {
    event e1/* ModeratorUpdate */( uint256 indexed p1/* target_obj_id */, uint256 indexed p2/* action_type */, uint256 indexed p3/* target_account */, uint256 p4/* sender_account_id */, uint256 p5/* object_type */, uint256 p6/* authority_val */, uint256 p7/* timestamp */, uint256 p8/* block_number */ );
    /* event emitted when a moderator action takes place */
    /* action_type: <4>modify_moderator_accounts, <5>enable/disable_interactible_checkers, <2>add_interactible account, <16>revoke_author_privelages, <17>block_accounts */

    event e2/* IndexItem */( string indexed p1/* tag */, uint256 indexed p2/* item */, uint256 indexed p3/* item_type */, string p4/* string_data */, uint256 p5/* sender_account */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event emitted when an item or object is indexed using a given or specified string */
    
    event e3/* AliasObject */( uint256 indexed p1/* target_id */, uint256 indexed p2/* sender_acc_id */, string indexed p3/* indexed_alias_string */, string p32/* alias_string */, uint256 p4/* timestamp */, uint256 p5/* block_number */ );
    /* event emitted when an object is aliased or named */

    event e4/* Data */( uint256 indexed p1/* target_id */, uint256 indexed p2/* sender_acc_id */, uint256 indexed p3/* context */, string p4/* string_data */, uint256 p5/* int_data */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event emitted when some data is added to an object */

    event e5/* Metadata */( uint256 indexed p1/* target_obj_id */, uint256 indexed p2/* sender_account_id */, uint256 indexed p3/* context */, string p4/* metadata */, uint256 p5/* timestamp */, uint256 p6/* block_number */);
    /* event emitted when metadata is added to an object */


    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    E34.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the E34 library */

    G5 private gv5/* contractsData */;
    /* global variable that points to the G5 contract */

    G52 private gv6/* contractsData2 */;
    /* global variable that points to the G52 contract */

    F5 private gv7/* subscriptionData */;
    /* global variable that points to the F5 contract */

    H5 private gv8/* tokensData */;
    /* global variable that points to the H5 contract */

    H52 private gv9/* tokensData2 */;
    /* global variable that points to the H52 contract */

    constructor(address p1/* bootaddress */) {
        /* called when the contract is created for the first time */

        gv2/* boot_address */ = p1/* bootaddress */;
        /* sets the address set to boot the contract */
    }

    /* auth */
    modifier f151(address v1/* caller */) {
        /* modifier used to ensure the sender is an address that can interact with the contract */

        require(gv3/* lock_addresses_mapping */[v1/* caller */] == true);
        /* ensures the sender can interact with the contract */

        _;
    }//-----TEST_OK-----

    /* boot */
    function f158(
        address[7] memory p1/* boot_addresses */,
        uint256[][] memory p2/* boot_id_data_type_data */,
        string[][] memory p3/* boot_object_metadata */,
        uint256[] memory p4/* new_main_contract_config */
    ) external {
        /* boots the contract for the first and only time */
        /* boot_addresses: [0]mainAddress , [1]E52Address , [2]SubscriptionDataAddress , [3]contractsDataAddress, [4]contractsData2Address, [5]tokensDataAddress, [6]tokensData2Address */

        require(msg.sender == gv2/* boot_address */ && !gv1/* booted */);
        /* ensure the sender is the address that was set to boot the contract */

        gv1/* booted */ = true;
        /* set the contract as booted */
        
        for (uint256 t = 0; t < p1/* boot_addresses */.length; t++) {
            /* for each address specified by the booter that should be able to interact with the contract */

            gv3/* lock_addresses_mapping */[p1/* boot_addresses */[t]] = true;
            /* set the address status to true */
        }

        gv7/* subscriptionData */ = F5( p1/* boot_addresses */[ 2 /* SubscriptionDataAddress */ ] );
        /* set the F5 contract using its address specified */

        gv5/* contractsData */ = G5( p1/* boot_addresses */[ 3 /* contractsDataAddress */ ] );
        /* set the G5 contract using its address specified */

        gv6/* contractsData2 */ = G52( p1/* boot_addresses */[ 4 /* contractsData2Address */ ] );
        /* set the G52 contract using its address specified */

        gv8/* tokensData */ = H5( p1/* boot_addresses */[ 5 /* tokensDataAddress */ ] );
        /* set the H5 contract using its address specified */

        gv9/* tokensData2 */ = H52( p1/* boot_addresses */[ 6 /* tokensData2Address */ ] );
        /* set the H52 contract using its address specified */

        E34.f102/* record_boot_id_types */(p2/* boot_id_data_type_data */, gv4/* num_data */);
        /* calls the boot data function in the E34 helper library for recording boot object id types */

        for (uint256 t = 0; t < p2/* boot_id_data_type_data */.length; t++) {
            /* for each boot object thats initialized */

            for (uint256 m = 0; m < p3/* boot_object_metadata */[t].length; m++) {
                /* for each metadata item specified for the boot object in focus */

                emit e5/* Metadata */(p2/* boot_id_data_type_data */[t][0/* id */], 0, 0, p3/* boot_object_metadata */[t][m], block.timestamp, block.number);
                /* emit default metadata for the boot object specified */
            }
        }
        E34.f94/* update_main_contract_limit_data */(p4/* new_main_contract_config */, gv4/* num_data */);
        /* set the default main contract data used in the contract */
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* record_obj_type_and_creator */
    function f171( 
        uint256 p1/* object_type */, 
        uint256 p3/* user_acc_id */, 
        uint256 p4/* obj_id */ 
    ) external f151(msg.sender){
        /* records the object type and author into storage */

        require(p1/* object_type */ > 15 && p1/* object_type */ < 37);
        /* ensure the object type specified is valid */
        
        if(p1/* object_type */!= 29/* 29(account_obj_id) */){
            /* if the object type being created is not an account since account data types are not recorded */

            gv4/* num_data */.num[p4/* obj_id */][ 0 /* control */ ][ 0 /* data_type */ ] = p1/* object_type */;
            /* record the new object type in its account's control module */
        }
        if (p1/* object_type */ != 29 && p1/* object_type */ != 24  && p1/* object_type */ != 35) {
            /* 29(account_obj_id) 24(shadow_object) 35(tag_object) */
            /* if its not one of these three types, the object type can have its author recorded */
            
            gv4/* num_data */.int_int_int[p4/* obj_id */][ 0 /* control */ ][ 0 /* author_owner */ ] = p3/* user_acc_id */;
            //record author and owner of new object id
        }
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_mod_work */
    function f217(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f151(msg.sender) {
        /* transactions associated with moderator work are sent here */
        /* 
            <1>modify_metadata, <2>add_interactible account, <3>modify_token_exchange  <4>modify_moderator_accounts> <5>enable/disable_interactible_checkers <10>alias_objects <11>modify_subscription <13>add_data <16>revoke_author_privelages <17>block_accounts
            
            0[<0>20000 (mod action) , <1>action]  
        */ 

        uint256[][5] memory v1/* target_id_data */ = E3.f21/* get_primary_secondary_target_data */(p1/* tx_data */);
        /* get the data used to perform moderator actions */

        uint256 v2/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* record the action specified */

        if ( v2/* action */ == 1 /* <1>modify metadata */ ) {
            /* if the action is modify metadata action */

            f220/* execute_modify_metadata */(v1/* target_id_data */, p1/* tx_data */);
            /* call hte execute modify metadata function with the required arguments */
        } 
        else if ( v2/* action */ == 2/* <2>add_interactible account */ ||  v2/* action */ == 5 /* <5>enable/disable_interactible_checkers */ || v2/* action */ == 17/* <17>block_accounts */) {
            /* if the action is an add interaction account or enable/disable interactible chekers action */

            f219/* modify_interactibles */(v1/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */, v2/* action */);
            /* call the modify interactibles function with the required arguments */
        }
        else if ( v2/* action */ == 4 /* <4>modify_moderator_accounts */ ) {
            /* if the action is modify moderator accounts function */

            f218/* modify_moderators */(v1/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */);
            /* call the modify moderators function with the required arguments */
        } 
        else if ( v2/* action */ == 10 || v2/* action */ == 13 /* <13>add_data */ ) {
            /* if the action is an alias object or add data action */

            if (v2/* action */ == 10 /* <10>alias_objects */) {
                /* if data is being aliased */

                f137/* require_target_author */( v1/* target_id_data */[ 0 /* target_ids */ ], p1/* tx_data */.sv1/* user_acc_id */ );
                /* require the sender to be the author of the targeted objects being aliased */
            }
            f221/* alias_object_add_data */(v1/* target_id_data */, p1/* tx_data */, v2/* action */);
            /* run the alias object add data action with the required function */
        }
        else if ( v2/* action */ == 12 /* <12>record_entity_in_tag */ ) {
            /* if the action is an index item action */

            require(p1/* tx_data */.sv2/* can_sender_vote_in_main_contract */);
            /* ensure that the sender can vote in the main contract */
            
            f222/* execute_record_item_in_tag */(v1/* target_id_data */, p1/* tx_data */.sv6/* strs */ , p1/* tx_data */.sv1/* user_acc_id */);
            /* run the index item function with the specified arguments required */
        }
        else if(v2/* action */ == 16 /* <16>revoke_author_privelages */){
            /* if the action is a revoke author privelages action */

            f276/* revoke_author_privelages */(v1/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */);
        }
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* update_main_contract_limit_data */
    function f94(uint256[] memory p1/* new_main_contract_config */) external f151(msg.sender) {
        /* updates the main contract data used in the contract */
        E34.f94/* update_main_contract_limit_data */(p1/* new_main_contract_config */, gv4/* num_data */);
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* archive_data */
    function f211(uint256[] memory p1/* proposal_ids */, uint256 p2/* sender_acc_id */) external f151(msg.sender){
        /* function that archives or deletes the data type and author data from storage */

        f137/* require_target_author */(p1/* proposal_ids */, p2/* sender_acc_id */);
        /* requires that the sender is the author of the targets being archived */

        E34.f96/* archive_data */(p1/* proposal_ids */, gv4/* num_data */);
        /* runs the archive data function in the E34 helper library */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_consensus_moderator_actions */
    function f275(
        uint256[][5][5] memory p1/* data */,
        uint256[21] memory p2/* consensus_type_data */
    ) external f151(msg.sender){
        /* runs the consensus moderator actions */
        /* 
            data[0]: modify_moderators, 
            data[1]: enable/disable_interactible_checkers, 
            data[2]: add_interactible_account,
            data[3]: revoke_author_privelages,
            data[4]: block_accounts
        */

        if(p2/* consensus_type_data */[16/* modify_moderators */] != 0){
            /* if modify moderator actions exist */

            f218/* modify_moderators */(p1/* data */[0/* modify_moderators */], 0);
            /* call the modify moderator function */
        }

        if(p2/* consensus_type_data */[17/* enable_disable_interactible_checkers */] != 0){
            /* if enable disable interactible checkers exists */

            f219/* modify_interactibles */(p1/* data */[1/* enable/disable_interactible_checkers */], 0, 5/* enable_disable_interactible_checkers */);
            /* call the modify interactibles function with action code 5[enable_disable_interactible_checkers] */
        }

        if(p2/* consensus_type_data */[18/* add_interactible_account */] != 0){
            /* if add interactible accounts actions exists */

            f219/* modify_interactibles */(p1/* data */[2/* add_interactible_account */], 0, 1/* add_interactible_account */);
            /* call the modify interactibles function with action code 1[add_interactible_account] */     
        }

        if(p2/* consensus_type_data */[19/* revoke_author_privelages */] != 0){
            /* if a revoke author privelages actions exist */

            f276/* revoke_author_privelages */(p1/* data */[3/* revoke_author_privelages */], 0);
            /* call the revoke author privelages function */
        }

        if(p2/* consensus_type_data */[20/* block_accounts */] != 0){
            /* if a block accounts action exists */

            f219/* modify_interactibles */(p1/* data */[4/* block_accounts */], 0, 17/* block_accounts */);
            /* call the modify interactibles function with action code 17[block_accounts] */
        }
    }




    /* revoke_author_privelages */
    function f276(
        uint256[][5] memory p1/* target_id_data */, 
        uint256 p2/* sender_acc_id */ 
    ) private {
        /* function used to revoke a set of targets author privelages */
        /* modify_moderators: target_id_data[0] = targets, target_id_data[2] = sender_accounts */

        E34.f277/* revoke_author_owner_privelages */(p1/* target_id_data */, gv4/* num_data */, p2/* sender_acc_id */);
        /* call the revoke author owner privelages function in the E34 library */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target being modified */

            uint256 v3/* sender */ = p2/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 2 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            uint256 v4/* target_id */ = p1/* target_id_data */[ 0 /* target_ids */ ][r];
            /* initialize a variable to contain the target id in focus */

            emit e1/* ModeratorUpdate */( v4/* target_id */, 16, f133/* read_author_owner */(v4/* target_id */), v3/* sender */, f135/* read_id_type */(v4/* target_id */), 1, block.timestamp, block.number );
            /* emit a moderator update event */
        }
    }


    /* modify_moderators */
    function f218( 
        uint256[][5] memory p1/* target_id_data */, 
        uint256 p2/* sender_acc_id */ 
    ) private {
        /* function used to modify the moderators of a given object */
        /* modify_moderators: target_id_data[0] = targets, target_id_data[1] = new_moderators, target_id_data[2] = sender_accounts */

        E34.f100/* modify_moderators */(p1/* target_id_data */, gv4/* num_data */, p2/* sender_acc_id */);
        /* call the modify moderators function with the specified arguments in the E34 helper library */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target being modified */

            uint256 v1/* target_type */ = gv4/* num_data */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ][ 0 /* control */ ][ 0 /* data_type */ ];
            /* initialize a variable that holds the target type of the object in focus */

            uint256 v2/* authority_val */ = gv4/* num_data */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ][ 1 /* <1>moderator_accounts */ ][ p1/* target_id_data */[ 1 /* secondary_target_ids */ ][r] ];
            /* initialize a variable that holds the new moderator status of the target specified */

            uint256 v3/* sender */ = p2/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 2 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            emit e1/* ModeratorUpdate */( p1/* target_id_data */[ 0 /* target_ids */ ][r], 4, p1/* target_id_data */[ 1 /* secondary_target_ids */ ][r], v3/* sender */, v1/* target_type */, v2/* authority_val */, block.timestamp, block.number );
            /* emit a moderator update event */
        }
    }

    /* modify_interactibles */
    function f219(
        uint256[][5] memory p1/* target_id_data */,
        uint256 p2/* sender_acc_id */,
        uint256 p3/* action */
    ) private {
        /* function that modifies the accounts that can interact with a given set of objects and enables/disables the checker altogether */
        /* action : 5 = enable/disable interactible checkers , 1 = add_interactible account, 17 = block_accounts */
        /* 
            enable/disable interactible checkers: target_id_data[0] = targets,  target_id_data[3] = sender_account_ids

            add_interactible account: target_id_data[0] = targets, target_id_data[1] = new_interactibles, target_id_data[2] = new_time_limits, target_id_data[3] = sender_account_ids

            block_accounts: target_id_data[0] = targets, target_id_data[1] = new_interactibles, target_id_data[2] = new_time_limits, target_id_data[3] = sender_account_ids
        */

        uint256[2][] memory v1/* vals */ = E34.f99/* modify_interactibles */(p1/* target_id_data */, gv4/* num_data */, p2/* sender_acc_id */, p3/* action */);
        /* calls the modify interactible function in the E34 library function */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target id specified */

            uint256 v2/* target_type */ = gv4/* num_data */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ][ 0 /* control */ ][ 0 /* data_type */ ];
            /* initialize a variable that holds the object type for the target in focus */

            uint256 v3/* sender */ = p2/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 3 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            emit e1/* ModeratorUpdate */( p1/* target_id_data */[ 0 /* target_ids */ ][r], p3/* action */, v1/* vals */[r][0/* new_account_target */], v3/* sender */, v2/* target_type */, v1/* vals */[r][1/* new_account_time_limits */], block.timestamp, block.number );
            /* emit a moderator update event */
        }
    }





    /* execute_modify_metadata */
    function f220(
        uint256[][5] memory p1/* target_id_data */,
        E3.TD/* TransactionData */ calldata p2/* tx_data */
    ) private {
        /* function used for modifying metadata for a given set of targets */

        E34.f283/* require_target_moderators */(p1/* targets */[ 0 /* target_ids */ ], p2/* tx_data */.sv1/* user_acc_id */, p1/* targets */[ 4/* e */ ], gv4/* num_data */);
        /* ensure the sender is a moderator of the given set of targets */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target specified */

            emit e5/* Metadata */( p1/* target_id_data */[ 0 /* target_ids */ ][r], p2/* tx_data */.sv1/* user_acc_id */, p1/* target_id_data */[ 1 /* contexts */ ][r], /* context */ p2/* tx_data */.sv6/* strs */[0][r], block.timestamp, block.number );
            /* emits the metadata event */
        }
    }

    /* execute_record_item_in_tag */
    function f222(
        uint256[][5] memory p1/* target_id_data */,
        string[][] memory p2/* string_data */,
        uint256 p3/* sender_acc_id */
    ) private {
        /* function used for indexing data */
        /* target_ids -> item being recorded */

        E34.f98/* execute_record_item_in_tag */(p1/* target_id_data */, gv4/* num_data */, p3/* sender_acc_id */);
        /* calls the index items function in the E34 helper library */

        for ( uint256 t = 0; t < p1/* target_id_data */[ 0 /* target_ids */ ].length; t++ ) {
            /* for each target item specified */

            uint256 v1/* item_id_type */ = gv4/* num_data */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][t] ][ 0 /* control */ ][ 0 /* data_type */ ];
            /* get the object type of the target in focus */

            emit e2/* IndexItem */( p2/* string_data */[0][t], p1/* target_id_data */[ 0 /* target_ids */ ][t], v1/* item_id_type */, p2/* string_data */[1][t], p3/* sender_acc_id */, block.timestamp, block.number );
            /* emit an index item event */
        }
    }

    /* alias_object_add_data */
    function f221(
        uint256[][5] memory p1/* target_id_data */,
        E3.TD/* TransactionData */ calldata p2/* tx_data */,
        uint256 p3/* action */
    ) private {
        /* function that aliases objects and adds data to objects */
        /* action : 10 = alias, 13 = add_data */

        E34.f67/* alias_object_add_data */(p1/* target_id_data */, p2/* tx_data */.sv2/* can_sender_vote_in_main_contract */, gv4/* num_data */, p3/* action */, p2/* tx_data */.sv1/* user_acc_id */);
        /* runs the alias object or add data function in the E34 helper library */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target specified */

            if (p3/* action */ == 10) {
                /* if the action is an alias object action */

                emit e3/* AliasObject */( p1/* target_id_data */[ 0 /* target_ids */ ][r], p2/* tx_data */.sv1/* user_acc_id */, p2/* tx_data */.sv6/* strs */[0][r], p2/* tx_data */.sv6/* strs */[0][r], /* pointer to object */ block.timestamp, block.number );
                /* emit an alias object event */
            } else {
                emit e4/* Data */( p1/* target_id_data */[ 0 /* target_ids */ ][r], p2/* tx_data */.sv1/* user_acc_id */, p1/* target_id_data */[ 1 /* contexts */ ][r], p2/* tx_data */.sv6/* strs */[0][r], p1/* target_id_data */[ 2 /* int_data */ ][r], block.timestamp, block.number );
                /* emit an add data event */
            }
        }
    }






    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* execute_reconfig_consensus_checkers */
    function f193(
        uint256 p1/* modify_target_obj_id */,
        uint256 p2/* target_contract_authority */
    ) external view {
        /* function that checks the target type and contract authority adata for a new proposal object created */

        uint256 v1/* target_type */ = f135/* read_id_type */(p1/* modify_target_obj_id */);
        /* reads and records the id type for the target object specified */

        require(v1/* target_type */ == 31 || v1/* target_type */ == 30 || v1/* target_type */ == 33);
        /* ensure the target type is valid */
        /* <31> (type token_exchange)  <30> contract_obj_id  33(subscription_object) */

        if ( v1/* target_type */ == 30 /* contract_obj_id */ ) {
            /* if the target is a contract object */

            require(p2/* target_contract_authority */ == p1/* modify_target_obj_id */);
            /* ensure the target is the contract authority of the new proposal */
        }
    }

    /* ensure_interactibles */
    function f69(uint256[] memory p1/* targets */, uint256 p2/* sender_acc_id */) public view {
        /* ensures the sender can interact with a specified set of targets */

        E34.f69/* ensure_interactibles */(p1/* targets */, gv4/* num_data */, p2/* sender_acc_id */);
        /* calls the ensure interactible function in the E34 helper library */
    }

    /* ensure_interactibles_for_multiple_accounts */
    function f257(
        uint256[] memory p1/* targets */, 
        uint256[] memory p2/* sender_accounts */, 
        uint256 p3/* single_sender_acc */ 
    ) public view {
        /* ensures the senders can interact with a given set of targets */

        if(p2/* sender_accounts */.length == 0){
            /* if the sender accounts array contains no data */

            E34.f69/* ensure_interactibles */(p1/* targets */, gv4/* num_data */, p3/* sender_acc_id */);
            /* calls the ensure interactible function in the E34 helper library */
        }
        else{
            /* if the sender accounts array contains data */

            E34.f257/* ensure_interactibles_for_multiple_accounts */(p1/* targets */, gv4/* num_data */, p2/* sender_accounts */);
            /* calls the ensure interactible for multiple accounts function in the E34 helper library */
        }
        
    }



    /* require_target_authors */
    function f138(
        uint256[] memory p1/* targets */, 
        uint256[] memory p2/* second_targets */, 
        uint256 p3/* sender_acc_id */
    ) external view {
        /* ensures the author of the targets passed is the sender account */
        f137/* require_target_author */(p1/* targets */, p3/* sender_acc_id */);
        f137/* require_target_author */(p2/* second_targets */, p3/* sender_acc_id */);
    }



    /* require_target_author */
    function f137(uint256[] memory p1/* targets */, uint256 p3/* sender_acc_id */) 
    public view returns(uint256[] memory v1/* target_authors */){
        /* requires the author of a given set of targets is the sender account supplied */

        v1/* target_authors */ = new uint256[](p1/* targets */.length);

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in focus */

            uint256 v2/* object_author */ = f133/* read_author_owner */(p1/* targets */[t]);
            
            require(v2/* object_author */ == p3/* sender_acc_id */);
            /* require that the target was created by the sender account  */

            v1/* target_authors */[t] = v2/* object_author */;
        }
    }

    /* require_id_type */
    function f136(uint256[] memory p1/* _ids */, uint256 p2/* id_type */) public view {
        /* ensures that the targets passed are of a specific object type */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each target */

            require( f135/* read_id_type */(p1/* _ids */[t]) == p2/* id_type */ );
            /* ensure that the id type set in the targets objec is the type specified */
        }
    }





    /* require_target_moderators */
    function f283(
        uint256[] memory p1/* targets */, 
        uint256 p2/* sender_acc_id */, 
        uint256[] memory p3/* sender_accounts */
    ) external view {
        /* requires the sender account is a moderator of the specified targets */
        E34.f283/* require_target_moderators */(p1/* targets */, p2/* sender_acc_id */, p3/* sender_accounts */, gv4/* num_data */);
    }

    

    /* read_multiple_id_types */
    function f134(uint256[] memory p1/* _ids */) 
    external view returns (uint256[] memory v1/* id_types */) {
        /* returns an array of id types for target ids specified */

        v1/* id_types */ = new uint256[](p1.length);
        /* initialize the return variable as a new array whose lenght is the number of targets specified */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each target specified */
            
            v1/* id_types */[t] = f135/* read_id_type */(p1/* _ids */[t]);
            /* read and record the id type */
        }
    }

    /* read_id_type */
    function f135(uint256 p1/* _id */) public view returns (uint256) {
        /* returns the object type of a specified id */
        return gv4/* num_data */.num[p1/* _id */][ 0 /* control */ ][ 0 /* data_type */ ];
    }




    /* read_author_owners */
    function f132(uint256[] memory p1/* _ids */) 
    public view returns (uint256[] memory v1/* id_authors */) {
        /* reads and returns the authors of a given set of targets */

        v1/* id_authors */ = new uint256[](p1.length);
        /* initialize the return value as a new array whose length is the number of targets specified */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each target specified */

            v1/* id_authors */[t] = f133/* read_author_owner */(p1/* _ids */[t]);
            /* read and record the author owner of the target */
        }
    }

    /* read_author_owner */
    function f133(uint256 p1/* _id */) public view returns (uint256) {
        /* returns the author of a specified target object */
        return gv4/* num_data */.int_int_int[p1/* _id */][ 0 /* control */ ][ 0 /* author_owner */ ];
    }




    /* ensure_interactibles_get_authors */
    function f188(
        uint256[] memory p1/* targets */,
        uint256[] memory p2/* sender_accounts */, 
        uint256 p3/* sender_acc_id */
    ) external view returns (uint256[] memory){
        /* ensures the sender or senders can interact with a given set of targets and returns the authors of the targets */

        f257/* ensure_interactibles_for_multiple_accounts */(p1/* targets */, p2/* sender_accounts */, p3/* sender_acc_id */);
        /* calls the ensure interactibles function */

        return f132/* read_author_owners */(p1/* targets */);
        /* retuns the authors of the targets */
    }

    /* require_target_author_or_moderator */
    function f244(
        uint256[] memory p1/* targets */, 
        uint256 p2/* sender_acc_id */, 
        uint256 p3/* action */
    ) external view {
        /* action: <14>modify_proposal, <15>modify_contract */

        /* ensures the sender of the targets is the author if proposals are being modified, or a moderator if contracts are being modified */

        if(p3/* action */ == 15/* <15>modify_contract */){
            /* if contracts are being modified */

            E34.f242/* require_target_moderator */(p1/* targets */, p2/* sender_acc_id */, gv4/* num_data */);
            /* ensure the sender is a moderator of each target specified */
        }
        else{
            /* if proposals are being modified */

            f137/* require_target_author */( p1/* targets */, p2/* sender_account */ );
            /* ensuer the sender is the author of each target specified */
        }
    }





    /* get_interactible_checker_settings | get_auth_privelages_setting */
    function f254(uint256[] memory p1/* targets */, uint256 p2/* action */) 
    external view returns (bool[] memory){
        /* returns the interactible setting or auth_privelages setting for each target specified. For each target, true means interactible setting has been enabled and specified accounts can interact with the target. In the case of get_auth_privelage_setting, true means auth privelages have been disabled. */
        /* 0 - get_interactible_checker_settings, 1 - get_auth_privelages_setting */

        return E34./* get_interactible_checker_settings | get_auth_privelages_setting */f254(p1/* targets */, gv4/* num_data */, p2/* action */);
    }

    /* get_moderator_settings */
    function f255(uint256[] memory p1/* targets */, uint256[][] memory p2/* accounts */)
    external view returns (bool[][] memory){
        /* returns the moderator setting for a list of specified accounts on each target passed. For each target, true means the specified account is a moderator of the target */

        return E34./* get_moderator_settings */f255(p1/* targets */, p2/* accounts */, gv4/* num_data */);
    }

    /* get_interactible_time_limits | blocked_account_time_limits */
    function f256(
        uint256[] memory p1/* targets */, 
        uint256[][] memory p2/* accounts */, 
        uint256 p3/* time_or_amount */,
        uint256 p4/* action */
    ) external view returns (uint256[][] memory){
        /* returns the amount of time a specified set of accounts can interact with specified targets */
        /* action[2]= get_interactible_time_limits,  action[3]= blocked_account_time_limits */
        /* time_or_amount<0>:the expiry time set, time_or_amount<1>:amount of time left before expiry */

        return E34./* get_interactible_time_limits */f256(p1/* targets */, p2/* accounts */, p3/* time_or_amount */, gv4/* num_data */, p4/* action */);
    }




    //
    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
    /* set_auth */
    // function f1322(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ 0 /* control */ ][ 0 /* author_owner */ ] = p1/* _ids */[t][1];
    //     }
    // }

    /* delete_auth */
    // function f1323(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ 0 /* control */ ][ 0 /* author_owner */ ] = 0;
    //     }
    // }


    /* set_id_type */
    // function f1352(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.num[ p1/* _id */[t][0] ][ 0 /* control */ ][ 0 /* data_type */ ] = p1/* _ids */[t][1];
    //     }
    // }

    /* delete_id_type */
    // function f1353(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.num[ p1/* _id */[t][0] ][ 0 /* control */ ][ 0 /* data_type */ ] = 0;
    //     }
    // }


     /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv3/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }


    // function func() external f151(msg.sender) {

    // }



    // /* get_booted */
    // function f1572() external view returns (bool){
    //     return gv1/* booted */;
    // }

    /* get_boot_data */
    // function f1573( address[7] calldata p1/* boot_addresses */ ) external view returns (uint256[7] memory v1/* data */){
    //     for (uint256 t = 0; t < p1/* boot_addresses */.length; t++) {
    //         if(gv3/* lock_addresses_mapping */[p1/* boot_addresses */[t]]){
    //             v1/* data */[t] = 1;
    //         }else{
    //             v1/* data */[t] = 0;
    //         }
    //     }
    // }

    /* read_data */
    // function f1574() public view returns(uint256[] memory v1/* data */){
    //     v1/* data */ = new uint256[](1);
    //     v1/* data */[0] = gv4/* num_data */.num[ 2 /* main_contract_obj_id */ ][1][16];
    // }


    /* scan_num */
    // function f207(uint256[][] calldata p1/* _ids */) 
    // external view returns (uint256[] memory v1/* data */) {
    //     /* scans the num storage object for its data */

    //     v1/* data */ = new uint256[](p1.length);
    //     /* intializes the return value as a new array whose length is the number of ids targeted */

    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         /* for each targeted value specified */

    //         v1/* data */[t] = gv4/* num_data */.num[ p1/* _ids */[t][0] ][ p1/* _ids */[t][1] ][ p1/* _ids */[t][2] ];
    //         /* set the data value at the specified location in the return variable position */
    //     }
    // }

}