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

import "./G52.sol"; /* import "./ContractsData2.sol"; */
import "./G3.sol"; /* import "./ContractsHelperFunctions.sol"; */
// import "./G32.sol"; /* import "./ContractsHelperFunctions2.sol"; */
import "./G33.sol"; /* import "./ContractsHelperFunctions3.sol"; */

import "../E5D/E3.sol"; /* import "../E5Data/E5HelperFunctions.sol"; */
import "../E5D/E32.sol"; /* import "../E5Data/E5HelperFunctions2.sol"; */
import "../E5D/E33.sol"; /* import "../E5Data/E5HelperFunctions3.sol"; */
import "../E5D/E5.sol"; /* import "./E5.sol"; */
import "../E5D/E52.sol"; /* import "./E52.sol"; */

import "../H5D/H5.sol"; /* import "../TokensData/TokensData.sol"; */
import "../H5D/H52.sol"; /* import "../TokensData/TokensData2.sol"; */

import "../F5D/F5.sol"; /* import "../SubscriptionData/SubscriptionData.sol"; */
import "../F5D/F32.sol"; /* import "./SubscriptionHelperFunctions2.sol"; */
// import "../F5D/F33.sol"; /* import "./SubscriptionHelperFunctions3.sol"; */


contract G5 {
    event e1/* MakeProposal */( uint256 indexed p1/* contract_id */, uint256 indexed p2/* proposal_object_id */, uint256 indexed p3/* consensus_type */, uint256 p4/* sender_account_id */, uint256 p5/* timestamp */, uint256 p6/* block_number */ );
    /* event emitted when a new proposal is created */

    event e2/* ModifyObject */( uint256 indexed p1/* contract_or_proposal_id */, uint256 indexed p2/* modifier_sender_account */, uint256 p3/* config_array_pos */, uint256 p4/* config_item_pos */, uint256 p5/* new_config_item */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event emitted when a contract or proposal is modified */


    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    G3.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the G3 library */

    F5 private gv5/* subscriptionData */;
    /* global variable that points to the F5 contract */

    H5 private gv6/* tokensData */;
    /* global variable that points to the H5 contract */

    H52 private gv7/* tokensData2 */;
    /* global variable that points to the H52 contract */

    G52 private gv8/* contractsData2 */;
    /* global variable that points to the G5 contract */

    E5 private gv9/* e5 */;
    /* global variable that points to the E5 contract */

    E52 private gv10/* e52 */;
    /* global variable that points to the E52 contract */

    /* auth */
    modifier f153(address v1/* caller */) {
        /* modifier used to ensure the sender is an address that can interact with the contract */

        require(gv3/* lock_addresses_mapping */[v1/* caller */] == true);
        /* ensures the sender can interact with the contract */

        _;
    }//-----TEST_OK-----

    constructor(address p1/* bootaddress */) {
        /* called when the contract is created for the first time */

        gv2/* boot_address */ = p1/* bootaddress */;
        /* sets the address set to boot the contract */
    }

    /* boot */
    function f160( 
        address[7] memory p1/* boot_addresses */, 
        uint256[][][] memory p2/* boot_data */,
        uint256[][] memory p3/* boot_id_data_type_data */
    ) external {
        /* boots the contract for the first and only time */

        require(msg.sender == gv2/* boot_address */ && !gv1/* booted */);
        /* ensure the sender is the address that was set to boot the contract */

        gv1/* booted */ = true;
        /* set the contract as booted */

        for (uint256 t = 0; t < p1/* boot_addresses */.length; t++) {
            /* for each address specified by the booter that should be able to interact with the contract */

            gv3/* lock_addresses_mapping */[p1/* boot_addresses */[t]] = true;
            /* set the address status to true */
        }

        gv10/* e52 */ = E52(p1/* boot_addresses */[ 1 /* E52Address */ ]);
        /* set the E52 contract using its address specified */

        gv9/* e5 */ = E5( p1/* boot_addresses */[ 0 /* mainAddress */ ] );
        /* set the E5 contract using its address specified */

        gv5/* subscriptionData */ = F5( p1/* boot_addresses */[ 2 /* SubscriptionDataAddress */ ] );
        /* set the F5 contract using its address specified */

        gv8/* contractsData2 */ = G52( p1/* boot_addresses */[ 4 /* contractsData2Address */ ] );
        /* set the G52 contract using its address specified */

        gv6/* tokensData */ = H5( p1/* boot_addresses */[ 5 /* tokensDataAddress */ ] );
        /* set the H5 contract using its address specified */

        gv7/* tokensData2 */ = H52( p1/* boot_addresses */[ 6 /* tokensData2Address */ ] );
        /* set the H52 contract using its address specified */

        G3.f108/* boot */(p2/* boot_data */, p3/* boot_id_data_type_data */, gv4/* num_data */);
        /* calls the boot function in G3 helper library that records the main contract object */
    }





    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* make_contract_or_consensus_request */
    function f174( E3.TD/* TransactionData */ calldata p1/* tx_data */ ) external f153(msg.sender) {
        /* transaction associated with creating a new contract or consensus object */

        uint256 v1/* object_type */ = p1/* tx_data */.sv4/* vals */[0][ 9 /* <9>object_type */ ];
        /* initialize a variable that holds the new object type */

        uint256 v3/* obj_id */ = p1/* tx_data */.sv7/* new_obj_id */;
        /* initialize a new variable that holds the new objects id */

        uint256[][] memory v4/* new_obj_id_num_data */ = f175/* record_new_objects_data */(p1/* tx_data */.sv4/* vals */, v3/* obj_id */, v1/* object_type */, p1/* tx_data */.sv1/* user_acc_id */, p1/* tx_data */.sv3/* temp_transaction_data */);
        /* calls the function that records the new objects data and initializes a return variable that holds the new objects data */

        if ( v1/* object_type */ == 30 /* 30(contract_obj_id) */ ) {
            /* if the new object being created is a contract */

            uint256 rp = gv6/* tokensData */.f258/* get_spend_exchange_reduction_proportion */();
            /* fetch the block limit reduction proportion value for the spend exchange */

            mapping(uint256 => uint256) storage v5/* main_contract_obj_id_num_1 */ = gv4/* num_data */.num[ 2 /* main_contract_obj_id */ ][1];
            /* initialize a storage variable that points to the main contract config data */

            E33.f81/* contract_data_checkers */(
                v4/* new_obj_id_num_data */[2/* exchanges */], 
                rp, 
                [
                    v5/* main_contract_obj_id_num_1 */[ 3 /* default_end_minimum_contract_amount */ ], 
                    v5/* main_contract_obj_id_num_1 */[ 9 /* default_spend_minimum_contract_amount */ ], 
                    v5/* main_contract_obj_id_num_1 */[ 23 /* <23>gas_anchor_price */ ]
                ],
                v4/* new_obj_id_num_data */[3/* amounts */]
            );
            /* call the contract data checker function in the E33 library */

            G3.f48/* check_contract_data */(v4/* new_obj_id_num_data */, v5/* main_contract_obj_id_num_1 */[30/* <30>absolute_proposal_expiry_duration_limit */]);
            /* call the contract config data checker function in the G3 library */

        } else {
            /* if the new object being created is a proposal */

            f190/* consensus_request_checkers */(p1/* tx_data */.sv1/* user_acc_id */, v3/* obj_id */, v4/* new_obj_id_num_data */, p1/* tx_data */.sv2/* can_sender_vote_in_main_contract */);
            /* call the new proposal object checkers to validate the new proposal object  */
        }
    }

    /* record_new_objects_data */
    function f175(
        uint256[][] memory p1/* tx_vals */,
        uint256 p2/* new_obj_id */, 
        uint256 p3/* object_type */,
        uint256 p4/* sender_acc_id */,
        uint256[] memory p5/* temp_transaction_data */
    ) private returns (uint256[][] memory v1/* new_obj_id_num_data */){
        /* records a new contract or proposals data in storage */
        
        uint256 v2 /* min_obj_len */ = p3/* object_type */ == 30 ? 20/* contract */ : 22/* proposal */;
        /* record the minimum object lenght for the new object being created */

        v1/* new_obj_id_num_data */ = E32.f31/* get_new_objects_data */( p1/* tx_vals */, p4/* sender_acc_id */, p5/* temp_transaction_data */, v2 /* min_obj_len */ );
        /* calls the get new object data function with the data specified */

        G3.f109/* record */(v1/* new_obj_id_num_data */, gv4/* num_data */, p2/* new_obj_id */, p3/* object_type */);
        /* calls the record data function in the G3 helper library */
    }


    /* consensus_request_checkers */
    function f190(
        uint256 p1/* sender_acc_id */,
        uint256 p2/* obj_id */, 
        uint256[][] memory p3/* new_obj_id_num_data */,
        bool p8/* can_sender_vote_in_main_contract */ 
    ) private {
        /* function that validates the new proposal that has been created by the sender */

        mapping(uint256 => uint256) storage p4/* new_obj_id_nums */ = gv4/* num_data */.num[p2/* obj_id */][1];
        /* initialize a storage mapping that points to the new objects configuration */

        (uint256 p5/* auto_wait_votes */, uint256 p7/* allow_external_buy_proposals */) = G3.f82/* run_consensus_request_checkers */(gv4/* num_data */, p2/* obj_id */, p8/* can_sender_vote_in_main_contract */);
        /* calls the consensus request checkers function in the G3 helper library to ensure the new proposal created is valid */

        bool p6/* record_target_payer_value */ = (p4/* new_obj_id_nums */[ 0 /* consensus_type */ ] == 2/* buy */);
        /* initialize a boolean whose value is determined by the consensus type, true if its a buy conensus action */

        gv8/* contractsData2 */.f194/* record_voter_work */( p4/* new_obj_id_nums */[5/* target_contract_authority */], p1/* sender_acc_id */, p6/* record_target_payer_value */, p2/* obj_id */, p5/* auto_wait_votes */, p7/* allow_external_buy_proposals */);
        /* calls the record voter function in the G52 contract */

        mapping(uint256 => uint256) storage v1/* contract_obj_num_1 */ = gv4/* num_data */.num[ p4/* new_obj_id_nums */[ 5 /* target_contract_authority */ ] ][1];
        /* initialize a storage mapping that points to the configuration of the proposals target contract authority */

        if ( v1/* contract_obj_num_1 */[ 4 /* <4>default_minimum_end_vote_bounty_amount */ ] != 0 || v1/* contract_obj_num_1 */[ 10 /* <10>default_minimum_spend_vote_bounty_amount */ ] != 0 ) {
            /* if a minimum amount of end or spend has been specified by the contract */

            uint256 rp = gv6/* tokensData */.f258/* get_spend_exchange_reduction_proportion */();
            /* get the active reduction proportion value from the spend exchange */
            
            uint256[][5] memory v2/* data */ = E33.f80/* ensure_minimum_amount_for_bounty */(
                gv4/* num_data */.num[ 2 /* main_contract_obj_id */ ][1][ 23 /* <23>gas_anchor_price */ ], 
                rp, 
                [ 
                    v1/* contract_obj_num_1 */[4/* <4>default_minimum_end_vote_bounty_amount */], 
                    v1/* contract_obj_num_1 */[ 10 /* <10>default_minimum_spend_vote_bounty_amount */ ], 
                    v1/* contract_obj_num_1 */[ 37 /* <37>bounty_limit_type(0 if relative, 1 if absolute) */ ]
                ], 
                p3/* new_obj_id_num_data */
            );
            /* ensures the minimum amount of end or spend bounty has been passed for the proposal */

            gv7/* tokensData2 */.f184/* execute_multi_transfer */( v2/* data */, p1/* sender_acc_id */, p2/* obj_id */, /* single_receiver */ true, /* single_receiver_instead */ true, /* single_sender_instead */ 1 );
            /* executes transfer of tokens for the specified tokens that are to be used as bounty for the new proposal */
        }


        if ( p4/* new_obj_id_nums */[ 0 /* consensus_type */ ] == 1 /* reconfig */ ) {
            /* if the consensus action is a reconfig action */

            gv10/* e52 */.f193/* execute_reconfig_consensus_checkers */(p4/* new_obj_id_nums */[ 9 /* modify_target */ ], p4/* new_obj_id_nums */[ 5 /* target_contract_authority */ ]);
            /* call the reconfig consensus checkers function in the E52 contract */
        }

        emit e1/* MakeProposal */( p4/* new_obj_id_nums */[ 5 /* target_contract_authority */ ], p2/* obj_id */, p4/* new_obj_id_nums */[ 0 /* consensus_type */ ], p1/* sender_acc_id */, block.timestamp, block.number );
        /* emit a new proposal creation event */
    }





    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_submit_consensus_request */
    function f200(
        uint256[] memory p1/* targets */, 
        uint256 p2/* sender_account */,
        uint256[][] memory p3/* payer_accounts */,
        uint256[][][2] memory p4/* target_bounty_exchanges_depth-data */ 
    ) external f153(msg.sender) {
        /* function used for submitting a set of consensus requests. target -> consensus request object */

        uint256[] memory v2/* target_payers_for_buy_data */ = gv10/* e52 */.f137/* require_target_author */( p1/* targets */, p2/* sender_account */ );
        /* ensure the sender is the author of the consensus objects being submitted */

        uint256[][][] memory v1/* target_nums */ = f78/* read_ids */(p1/* targets */, false);
        /* read the data stored for the specified targets and store them in a variable */

        (uint256[21] memory v3/* consensus_type_data */, bool[3] memory v11/* contains_subscription_contract_moderator_work */ ) = gv8/* contractsData2 */.f201/* run_all_consensus_checkers */(p1/* targets */, v1/* target_nums */, p4/* target_bounty_exchanges_depth-data */);
        /* call the consensus request checkers function in the G52 contract */

        if ( v3/* consensus_type_data */[ 0 /* spend */ ] != 0 || v3/* consensus_type_data */[ 2 /* buy */ ] != 0 ) {
            /* if the consensus actions contains a spend action or a buy action */

            uint256[][][2] memory v10/* exchange_trust_fees_data */ = gv6/* tokensData */.f88/* get_consensus_spend_mint_trust_fees */(v1/* target_nums */);
            /* initialize a variable to hold the trust fees charged for each token used in the spend or buy action */
            
            uint256[][5] memory v4/* data */ = G33.f63/* get_consensus_buy_spend_data */( p1/* targets */, v1/* target_nums */, v2/* target_payers_for_buy_data */, v10/* exchange_trust_fees_data */, v3/* consensus_type_data */ );
            /* initialize a variable containing all the transfer actions set to take place for the spend or buy action */

            gv7/* tokensData2 */.f184/* execute_multi_transfer */(v4/* data */, 0, 0, false, false, 1);
            /* call the multi-transfer action to send the tokens from the contracts' accounts to the targeted recipients(including the trust fee recipients) */
        }

        if ( v3/* consensus_type_data */[ 1 /* reconfig */ ] != 0 ) {
            /* if one of the consensus objects is a reconfig consensus action */

            uint256[] memory v7/* modify_target_ids */ = E3.f52/* fetch_modify_targets */(v1/* target_nums */);
            /* get the modify targets for each consensus action thats a reconfig action */

            uint256[] memory v8/* modify_target_id_types */ = gv10/* e52 */.f134/* read_multiple_id_types */(v7/* modify_target_ids */);
            /* initialize a variable that contains the id types for each modify target */

            uint256[][5][3] memory v9/* reconfig_data */ = G33.f55/* get_reconfig_data */( p1/* targets */, v1/* target_nums */, v8/* modify_target_id_types */ );
            /* initialize a three dimentional variable that contains the modify data sent to H5 and F5 contracts */

            if ( v9/* reconfig_data */[ 0 /* contract */ ][ 0 /* targets */ ].length != 0 ) {
                /* if there exists consensus actions involving modifying contract objects */

                f238/* modify_contract */( v9/* reconfig_data */[ 0 /* contract */ ], 0, 152/* <152>modify_contract_from_consensus */);
                /* call the modify contract function with its required arguments */
            }
            if ( v9/* reconfig_data */[ 1 /* exchange */ ][ 0 /* targets */ ].length != 0 ) {
                /* if there exists consensus actions involving modifying exchange objects */

                gv6/* tokensData */.f198/* modify_token_exchange */( v9/* reconfig_data */[ 1 /* exchange */ ], 0 );
                /* call the modify token exchange function with its required arguments */
            }
            if ( v9/* reconfig_data */[ 2 /* subscription_object */ ][ 0 /* targets */ ].length != 0 ) {
                /* if there exists consensus actions involving modifying subscription objects */

                gv5/* subscriptionData */.f196/* modify_subscription */( v9/* reconfig_data */[ 2 /* subscription_object */ ], 0 );
                /* call the modify token exchange function with its required arguments */
            }
        }

        if ( v3/* consensus_type_data */[ 3 /* authmint */ ] != 0 ) {
            /* if the consensus actions contains an authmint action */

            uint256[] memory e = new uint256[](0);
            /* initialize an array with lenght zero */

            (uint256[][5] memory v5/* data2 */,) = G33.f60/* get_consensus_mint_dump_data */( p1/* targets */, v1/* target_nums */, v3/* consensus_type_data */, 3 /* authmint */ );
            /* initialize a variable that holds the mint data */

            gv6/* tokensData */.f180/* execute_buy_or_sell_tokens */( v5/* data2 */, [uint256(0), 0, 0, 0], true, [e, e] );
            /* call the buy sell tokens action in the H5 contract */
        }

        if ( v3/* consensus_type_data */[ 4 /* 4-freeze/unfreeze */ ] != 0 ) {
            /* if the consensus actions contains a freeze or unfreeze */

            uint256[][6] memory v6/* data2 */ = G33.f61/* get_freeze_unfreeze_data */( v1/* target_nums */, v3/* consensus_type_data */ );
            /* initialize a variable that contains the freeze/unfreeze data */

            gv7/* tokensData2 */.f199/* execute_freeze_unfreeze_tokens */(v6/* data2 */, 0);
            /* call the freeze/unfreeze action in the H52 contract */
        }

        if ( v3/* consensus_type_data */[ 5 /* swap_tokens */ ] != 0 ) {
            /* if the consensus actions contains an authmint action */

            (uint256[][5] memory v7/* data2 */, uint256[][2] memory v8/* buy_sell_limits */) = G33.f60/* get_consensus_mint_dump_data */( p1/* targets */, v1/* target_nums */, v3/* consensus_type_data */, 5 /* swap_tokens */ );
            /* initialize a variable that holds the mint data */

            gv6/* tokensData */.f180/* execute_buy_or_sell_tokens */( v7/* data2 */, [uint256(0), 0, 0, 0], false, v8/* buy_sell_limits */ );
            /* call the buy sell tokens action in the H5 contract */
        }

        if ( v3/* consensus_type_data */[ 6 /* exchange_transfer */ ] != 0 ) {
            /* if the consensus actions contains an exchange transfer action */

            uint256[][6] memory v8/* data2 */ = F32.f233/* get_consensus_exchange_transfer_data */( p1/* targets */, v1/* target_nums */, v3/* consensus_type_data */ );
            /* initialize a variable that contains the exchange transfer data */

            gv6/* tokensData */.f230/* run_exchange_transfer */(v8/* data2 */, 0);
            /* call the exchange transfer function in the H5 contract */
        }

        if ( v3/* consensus_type_data */[ 7 /* stack_depth_swap */ ] != 0 ) {
            /* if the consensus actions contains an exchange transfer action */

            uint256[][6] memory v9/* data2 */ = F32.f241/* get_consensus_stack_depth_swap */( p1/* targets */, v1/* target_nums */, v3/* consensus_type_data */ );
            /* initialize a variable that contains the stack depth swap data */

            gv7/* tokensData2 */.f227/* stack_depth_swap */(v9/* data2 */, 0);
            /* call the stack depth swap function in the H5 contract */
        }

        if(v11/* contains_subscription_contract_moderator_work */[0/* subscriptions */]){
            /* if the consensus actions contains a subscriptions action */

            gv5/* subscriptionData */.f263/* subscription_consensus_action_receiver */(v1/* target_nums */, v3/* consensus_type_data */, p3/* payer_accounts */);
            /* call the subscription consensus action receiver function in the F5 contract */
        }

        if(v11/* contains_subscription_contract_moderator_work */[2/* moderator_actions */]){
            /* if the consensus actions contains a moderator action */

            uint256[][5][5] memory v10/* data */ = F32.f274/* get_consensus_moderator_action_data */(v1/* target_nums */, v3/* consensus_type_data */);
            /* initialize a variable that contains the moderator action data */

            gv10/* e52 */.f275/* run_consensus_moderator_actions */(v10/* data */, v3/* consensus_type_data */);
            /* call the consensus moderator actions function in the E52 contract */
        }

        /* processing order: 11, 12, 13, 14, 15,   0/2, 1,3, 4, 5, 6, 7,    8, 9, 10,   16, 17, 18, 19, 20 */
        /* those are proposal id types, for instance 0(zero) is a spend proposal and 2 is a buy proposal. so the order is based on the type of proposal with the contract actions taking precedence over the others */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_modify_proposals_or_contracts */
    function f238(
        uint256[][5] memory p1/* targets_id_data */, 
        uint256 p2/* sender_account */,
        uint256 p3/* action */
    ) public f153(msg.sender){
        /* function used to modify a targeted contract or proposal object */

        if(p3/* action */ != 152/* <152>modify_contract_from_consensus */){
            /* if the action is a modify contract or proposal */

            gv10/* e52 */.f244/* require_target_author_or_moderator */( p1/* targets */[0/* targets */], p2/* sender_account */, p3/* action */);
            /* ensure the sender is the author or moderator of the contract or consensus objects being modified */
        }

        bool v1/* update_main_contract_limit_data */ = G3.f243/* modify_target */(p1/* data */, gv4/* num_data */, p3/* action */); 
        /* call the modify target function in the G3 helper library */       

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each targeted contract or proposal being modified */

            uint256 v2/* sender_account */ = p2/* sender_account */;
            /* initialize a variable that contains the sender account */
            
            if(v2/* sender_account */ == 0){
                /* if sender account has been undefined, the sender is probably in the target id data */

                v2/* sender_account */ = p1/* data */[ 4 /* contract_authority */ ][t];
                /* reset the sender account value as the contract authority in the data array */
            }

            emit e2/* ModifyObject */( p1/* data */[ 0 /* targets */ ][t], v2/* sender_account */ , p1/* data */[ 1 /* target_array_pos */ ][t], p1/* data */[ 2 /* target_array_items */ ][t], p1/* data */[ 3 /* new_items */ ][t], block.timestamp, block.number);
            /* emit a modify object action */
        }

        if (v1/* update_main_contract_limit_data */) {
            /* if the main contract was modified */

            gv9/* e5 */.f206/* update_main_contract_limit_data */(f77/* read_id */( 2 /* main_contract_obj */, false )[ 1 /* config */ ] );
            /* update the main contract data stored in E5 */
        }
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* archive_proposals */
    function f111( uint256[] memory p1/* targets */ ) 
    external f153(msg.sender) returns (uint256[][][] memory ){
        /* archives a given set of specified targets and returns their data before deleting */
        return G3.f111/* archive_proposal_data */(p1/* targets */, gv4/* num_data */);
    }



    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* load_consensus_data */
    function f79(
        uint256[] memory targets, 
        uint256[] memory p3/* sender_accounts */,
        uint256 p4/* single_sender_account */
    ) external view returns (uint256[][][] memory , uint256[][4] memory) {
        /* returns the data stored in specified targets and bounty split proportion data set by the contract */
        return G3.f79/* load_consensus_data */( targets, gv4/* num_data */, p3/* sender_accounts */, p4/* single_sender_account */ );
    }

    /* read_ids */
    function f78(uint256[] memory p1/* _ids */, bool p2/* full_read */) 
    public view returns (uint256[][][] memory) {
        /* retuns a three dimentional object containing the data for each target specified */
        return G3.f78/* read_ids */(p1/* _ids */, gv4/* num_data */, p2/* full_read */);
    }

    /* read_id */
    function f77(uint256 p1/* id */, bool p2/* full_read */) 
    public view returns (uint256[][] memory) {
        /* reads the id for a specific contract or consensus object */
        return G3.f77/* read_id */(p1/* id */, gv4/* num_data */, p2/* full_read */);
    }




    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
    /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv3/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }

    // function func() external f153(msg.sender) {

    // }


    /* get_booted */
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
}
