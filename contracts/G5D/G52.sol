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

import "./G5.sol"; 
/* import "./ContractsData.sol"; */
// import "./G3.sol"; /* import "./ContractsHelperFunctions.sol"; */
import "./G32.sol"; /* import "./ContractsHelperFunctions2.sol"; */
import "./G33.sol"; /* import "./ContractsHelperFunctions3.sol"; */

import "../E5D/E3.sol"; /* import "../E5Data/E5HelperFunctions.sol"; */
import "../E5D/E32.sol"; /* import "../E5Data/E5HelperFunctions2.sol"; */
import "../E5D/E5.sol"; /* import "../E5D/E5.sol"; */
import "../E5D/E52.sol"; /* import "./E5D/E52.sol"; */

import "../F5D/F5.sol"; /* import "../SubscriptionData/SubscriptionData.sol"; */
import "../F5D/F32.sol"; /* import "./SubscriptionHelperFunctions2.sol"; */

import "../H5D/H5.sol"; /* import "../TokensData/TokensData.sol"; */
import "../H5D/H52.sol"; /* import "../TokensData/TokensData2.sol"; */


contract G52 {
    event e1/* RecordProposalVote */( uint256 indexed p1/* contract_id */, uint256 indexed p2/* consensus_id */, uint256 indexed p3/* voter_account_id */, uint256 p4/* vote */, uint256 p5/* timestamp */, uint256 p6/* block_number */);
    /* event emitted when a proposal is voted on by the sender */

    event e2/* EnterExtendExitContract */( uint256 indexed p1/* contract_id */, uint256 indexed p2/* sender_acc */, uint256 indexed p3/* action */, uint256 p4/* expiry */, uint256 p5/* force_exit_account */, uint256 p6/* block_number */, uint256 p7/* timestamp */ );
    /* event emitted when a sender enters a contract(action 3) or extends their stay in a contract(action 14) or exits a contract(action 11) or force exit a contract(action 18) */

    event e3/* SubmitProposal */( uint256 indexed p1/* proposal_id */, uint256 indexed p2/* contract_id */, uint256 p3/* timestamp */, uint256 p4/* block_number */ );
    /* event emitted when a sender submits a proposal after consensus */

    event archive/* ArchiveProposal */( uint256 indexed p1/* proposal_id */, uint256 indexed p2/* sender_acc */, uint256 p3/* timestamp */, uint256 p4/* block_number */ );
    /* event emitted when a sender archives a proposal after expirty */



    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    G32.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the G32 library */

    G5 private gv5/* contractsData */;
    /* global variable that points to the G5 contract */

    F5 private gv6/* subscriptionData */;
    /* global variable that points to the F5 contract */

    H5 private gv7/* tokensData */;
    /* global variable that points to the H5 contract */

    H52 private gv8/* tokensData2 */;
    /* global variable that points to the H52 contract */

    E5 private gv9/* e5 */;
    /* global variable that points to the E5 contract */

    E52 private gv10/* e52 */;
    /* global variable that points to the E52 contract */

    /* auth */
    modifier f154(address v1/* caller */) {
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
    function f161(address[7] calldata p1/* boot_addresses */) external {
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

        gv6/* subscriptionData */ = F5( p1/* boot_addresses */[ 2 /* SubscriptionDataAddress */ ] );
        /* set the F5 contract using its address specified */

        gv5/* contractsData */ = G5( p1/* boot_addresses */[ 3 /* contractsDataAddress */ ] );
        /* set the G5 contract using its address specified */

        gv7/* tokensData */ = H5( p1/* boot_addresses */[ 5 /* tokensDataAddress */ ] );
        /* set the H5 contract using its address specified */

        gv8/* tokensData2 */ = H52( p1/* boot_addresses */[ 6 /* tokensData2Address */ ] );
        /* set the H52 contract using its address specified */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_contract_transactions */
    function f189(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f154(msg.sender) 
    returns (uint256 v3/* new_entered_contracts */){
        /* transactions associated with contract actions are sent here */

        uint256 v4/* action */ = p1/* tx_data */.sv4/* vals */[0][1 /* action */];
        /* record the transaction action */

        uint256 v5/* general_action */ = p1/* tx_data */.sv4/* vals */[0][0];
        /* record the general action */

        if(v5/* general_action */ == 30000 /* token_transaction_work */){
            /* if the general action involves token action */

            uint256[][5] memory v6/* target_id_data */ = E3.f260/* get_contract_target_id_data */(p1/* tx_data */);
            /* calculate and set the data used for token actions involving a contract */

            if(v4/* action */ == 3 /* <3>enter_contract */){
                /* if the action is an enter contract action */

                f267/* execute_enter_extend_exit_contract_work */(v6/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */, v4/* action */);
                /* calls the function that executes entering a contract */

                v3/* new_entered_contracts */ = v6/* target_id_data */[ 0 /* target_ids */ ].length;
                /* record the number of entered contracts in the return value */
            }
            else if (v4/* action */ == 4 /* <4>vote_proposal */) {
                /* if the action is a vote proposal action */

                uint256[][][2] memory v7/* target_bounty_exchanges_depth-data */ = E32.f228/* get_nested_exch_data_for_bounties */(p1/* tx_data */.sv4/* vals */, v6/* target_id_data */[ 0 /* target_proposals */ ], 4, p1/* tx_data */.sv3/* temp_transaction_data */, p1/* tx_data */.sv1/* user_acc_id */);
                /* calculate and set the data used for exchange bounty collection after voting in a set of proposals */

                f195/* execute_vote_proposals */(
                    v6/* target_id_data */[ 0 /* target_ids */ ], /* proposal_ids */ 
                    p1/* tx_data */.sv1/* user_acc_id */, 
                    p1/* tx_data */.sv4/* vals */[ 3 /* target_proposal_votes */ ], 
                    p1/* tx_data */.sv2/* can_sender_vote_in_main_contract */, 
                    v7/* target_bounty_exchanges_depth-data */, 
                    v6/* target_id_data */[ 2 /* e */ ]
                );
                /* calls the execute vote proposals function for voting in a set of specified proposals */
            }
            else if (v4/* action */ == 11 /* <11>exit_contract */ || v4/* action */ == 18 /* <18>contract_force_exit_accounts */) {
                /* if the action is an exit contract action */

                f267/* execute_enter_extend_exit_contract_work */(v6/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */, v4/* action */);
                /* calls the exit contract function for exiting a set of contracts specified */
            }
            else if(v4/* action */ == 14 /* execute_extend_enter_contract_work */){
                /* if the action is an extend stay in contract action */

                f267/* execute_enter_extend_exit_contract_work */(v6/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */, v4/* action */);
                /* calls the extend enter contract function with the specified target contracts */
            }
            else if(v4/* action */ == 15 /* <15>archive_proposals_or_contracts */){
                /* if the action is an archive action */

                uint256[][][3] memory v8/* accounts_exchanges */ = E32.f49/* get_archive_nested_account_data */(p1/* tx_data */.sv4/* vals */, v6/* target_id_data */[ 0 /* target_proposals */ ]);
                /* get the accounts, exchanges and depth data in one variable */

                f210/* archive_proposals */( v6/* target_id_data */[ 0 /* target_proposals */ ], v8/* accounts_exchanges */, p1/* tx_data */.sv1/* user_acc_id */ );
                /* call the archive proposal function with the specified arguments */
            }
        }
    }


    /* execute_enter_extend_exit_contract_work */
    function f267(
        uint256[][5] memory p1/* targets|expiry|sender_accounts|target_force_exit_accounts */,
        uint256 p3/* sender_account */,
        uint256 p5/* action */
    ) private {
        /* combined function used for entering, extending entering and exiting contract */
        /* action: 3 = enter_contract, action: 14 = extend_enter_contract, action: 11 = exit_contract, action: 18 = force_exit_account */

        uint256[][][] memory v1/* targets_data */ = gv5/* contractsData */.f78/* read_ids */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */], false);
        /* read the contract data from the G5 contract */

        if(p5/* action */ == 3/* enter_contract */){
            /* if the action is an enter contract action */

            p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[4/* target_authors */] = gv10/* e52 */.f188/* ensure_interactibles_get_authors */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */], p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */], p3/* sender_account */);
            /* ensure the sender can interact with the contracts specified */

            G32.f112/* execute_enter_contract_work */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */, p3/* sender_account */, gv4/* num_data */, v1/* targets_data */);
            /* calls the enter contract function in the G32 helper library */

            uint256[][5] memory v3/* data */ = G33.f62/* get_enter_contract_multi_transfer_data */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */], v1/* targets_data */, p3/* sender_account */, p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */]);
            /* initialize a variable containing the data used for running the token transfer action when entering a contract */
        
            gv8/* tokensData2 */.f184/* execute_multi_transfer */(v3/* data */, 0, 0, false, false, 1 );
            /* call the multi-transfer function for transfering tokens to the contracts account */
            
        }
        else if(p5/* action */ == 14/* extend_enter_contract */){
            /* if the action is a extend enter contract action */

            gv10/* e52 */.f257/* ensure_interactibles_for_multiple_accounts */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */], p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */], p3/* sender_account */);
            /* ensure the senders can still interact with the contracts specified to ensure they cant extend their stay in a contract if the moderators have revoked their ability to re-enter and access contract */

            G32.f113/* execute_extend_enter_contract_work */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */, p3/* sender_account */, v1/* targets_data */, gv4/* num_data */);
            /* calls the extend stay in contract function in the G32 helper library */
        }
        else{
            /* if the action is an exit contracts action */

            if(p5/* action */ == 18/* <18>contract_force_exit_accounts */){
                /* if the action is a contract force exit accounts action */

                gv10/* e52 */.f283/* require_target_moderators */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */], p3/* sender_account */, p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */]);
            }

            G32.f114/* execute_exit_contract_work */(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */, p3/* sender_account */, gv4/* num_data */, v1/* targets_data */, p5/* action */);
            /* call the exit contract function in the G32 helper library */
        }

        for (uint256 t = 0; t < p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */].length; t++) {
            /* for each target contract specified */

            uint256 v4/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v4/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v4/* sender */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }

            uint256 v5/* expiry_time */ = 0;
            /* set the default expiry time value to zero */

            if(p5/* action */ == 3/* enter_contract */ || p5/* action */ == 14/* extend_enter_contract */){
                /* if action is an enter or extend enter contract action, expiry time should be specified */

                v5/* expiry_time */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[1/* expiry */][t];
                /* set the expiry time specified in the arguments array */
            }

            uint256 v6/* force_exit_account */ = 0;
            /* set the default force exit account targeted to zero */

            if(p5/* action */ == 18/* <18>contract_force_exit_accounts */){
                /* if the action is a force exit account action */

                v6/* force_exit_account */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[3/* target_force_exit_accounts */][t];
            }

            emit e2/* EnterExtendExitContract */( p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */][t], v4/* sender */, p5/* action */, v5/* expiry_time */, v6/* force_exit_account */, block.number, block.timestamp );
            /* emit a contract event */
        }
        
    }

    /* execute_vote_proposals */
    function f195(
        uint256[] memory p1/* targets */,
        uint256 p2/* sender_account */,
        uint256[] memory p3/* votes */,
        bool p4/* can_sender_vote_in_main_contract */,
        uint256[][][2] memory p5/* target_bounty_exchanges_depth-data */,
        uint256[] memory p6/* sender_accounts */
    ) private {
        /* function used for executing voting in a given set of specified proposal targets */

        (uint256[][][] memory v1/* target_nums_data */, uint256[][4] memory v2/* bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts */) = gv5/* contractsData */.f79/* load_consensus_data */(p1/* targets */, p6/* sender_accounts */, p2/* sender_account */);
        /* fetches the consensus targets' data and 'bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts', which contains the bounty split proportion specified by the target proposals' respective contract authorities(the contracts that the proposals are targeting)  */

        uint256[] memory v6/* voter_weight_balances */ = gv8/* tokensData2 */.f140/* balance_of */(v2[1/* voter_weight_exchanges */], v2[3/* sender_accounts */], v2[2/* voter_weight_exchange_depths */], 1/* unfrozen balances */);


        (bool[] memory v3/* include_transfers */, bool v4/* transfer_work */) = G32.f116/* execute_vote_proposal_checkers */( [p1/* targets */, p3/* votes */, p6/* sender_accounts */, v2[1/* voter_weight_exchanges */], v6/* voter_weight_balances */], p2/* sender_account */, p4/* can_sender_vote_in_main_contract */, v1/* target_nums_data */, gv4/* num_data */, p5/* target_bounty_exchanges */[0/* target_bounty_exchanges */]);
        /* execute the vote proposal checkers which updates the senders votes in the specified proposal targets and returns a boolean array specifying if bounty transfers are to take place for each target voted on. */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target proposal specified */

            uint256 v5/* sender */ = p2/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v5/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v5/* sender */ = p6/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }

            emit e1/* RecordProposalVote */( v1/* target_nums_data */[t][1][ 5 /* <5>target_contract_authority  */ ], p1/* targets */[t], v5/* sender */, p3/* votes */[t], block.timestamp, block.number );
            /* emit a vote event */
        }

        if (v4/* transfer_work */) {
            /* if there exists some bounty transfer work, which is the action involving collecting bounty after voting in a proposal */

            gv8/* tokensData2 */.f204/* execute_bounty_transfers */( p1/* targets */, v3/* include_transfers */, v2/* bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts */[0/* bounty_data */], p2/* sender_account */, p5/* target_bounty_exchanges */[0/* target_bounty_exchanges */], p5/* target_bounty_exchanges */[1/* depth-data */], p6/* sender_accounts */);
            /* calls the execute bounty transfer function in the H52 contract that transfers tokens from the proposal accounts to the sender's account */
        }
    }//-----CHANGED-----

    /* archive_proposals */
    function f210(
        uint256[] memory p1/* targets */,
        uint256[][][3] memory p2/* accounts_exchanges_depths */,
        uint256 p3/* sender_account_id */
    ) private {
        /* function used to archive proposals or contracts specified */

        gv10/* e52 */.f211/* archive_data */(p1/* targets */, p3/* sender_account_id */);
        /* calls the archive data function in the E52 contract */

        uint256[][][] memory v1/* target_data */ = gv5/* contractsData */.f111/* archive_proposals */(p1/* targets */);
        /* initialize a variable containing the target data for the contracts and proposals being archived */

        bool v2/* includes_transfers */ = G32.f118/* archive_data */(p1/* targets */, v1/* target_data */, gv4/* num_data */, p2/* accounts_exchanges_depths */);
        /* calls the archive data function in G32 helper library */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in the specified targets being archived */

            emit archive/* ArchiveProposal */(p1/* targets */[t], p3/* sender_account_id */, block.timestamp, block.number);
            /* emit an archive event */
        }

        if (v2/* includes_transfers */) {
            /* if tranfer actions are to take place since the sender has specified exchanges that the targets being archived have token balances in */

            gv8/* tokensData2 */.f212/* execute_archive_transfers */(p1/* targets */, p3/* sender_account_id */, p2/* accounts_exchanges_depths */[1/* balance_exchanges */],p2/* accounts_exchanges_depths */[2/* exchanges_depths */]);
            /* call the archive transfer function for transfering tokens out of the archived targets accounts to the senders account */
        }
    }//-----CHANGED-----




    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_all_consensus_checkers */
    function f201(
        uint256[] memory p1/* targets */, 
        uint256[][][] memory p2/* target_nums_data */,
        uint256[][][2] memory p3/* target_bounty_exchanges_depth-data */
    ) external f154(msg.sender) returns (
        uint256[21] memory v2/* consensus_type_data */,
        bool[3] memory v3/* contains_subscription_contract_moderator_work */
    ) {
        /* function responsible for ensuring consensus within a specified set of targets is unanimous */

        (v2/* consensus_type_data */, v3/* contains_subscription_contract_work */) = G32.f117/* run_all_consensus_checkers */(p1/* targets */, p2/* target_nums_data */, gv4/* num_data */);
        /* calls the consensus checker function in the G32 helper library */

        if( v3/* contains_subscription_contract_moderator_work */[1/* contracts */]){
            /* if the consensus actions contains a contracts action */

            uint256[][5][5] memory v4/* data */ = F32.f262/* get_consensus_contract_data */(p2/* target_nums_ */, v2/* consensus_type_data */);
            /* initialize a variable that contains the contract action data */

            f271/* run_consensus_contract_actions */(v2/* consensus_type_data */, v4/* data */, p3/* target_bounty_exchanges_depth-data */);
        }


        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target proposal specified */

            emit e3/* SubmitProposal */( p1/* targets */[t], p2/* target_nums_data */[t][1][ 5 /* target_contract_authority */ ], block.timestamp, block.number );
            /* emit a submit proposal event */
        }

    }//-----CHANGED-----


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_consensus_contract_actions */
    function f271(
        uint256[21] memory p1/* consensus_type_data */,
        uint256[][5][5] memory v4/* data */,
        uint256[][][2] memory p3/* target_bounty_exchanges_depth-data */
    ) private {
        /* runs the contract actions from the submit consensus function in G5. */

        if(p1/* consensus_type_data */[ 11 /* enter_contract */ ] != 0 ){
            /* if one of the actions involves a enter contract */
            
            f267/* execute_enter_extend_exit_contract_work */(
                v4/* data */[0/* enter_contract_data */],
                0/* sender_account */, 
                3/* enter_contracts */
            );
        }

        if(p1/* consensus_type_data */[ 12 /* extend_enter_contract */ ] != 0){
            /* if one of the actions involves a extend contract */

            f267/* execute_enter_extend_exit_contract_work */(
                v4/* data */[1/* extend_enter_contract_data */],
                0/* sender_account */,
                14/* extend_enter_contract */
            );
        }

        if(p1/* consensus_type_data */[ 13 /* vote_proposal */ ] != 0){
            /* if one of the actions involves a vote in proposal */

            f195/* execute_vote_proposals */(
                v4/* data */[2/* vote_contract_proposal_data */][0/* target_proposals */],
                0/* sender_account */,
                v4/* data */[2/* vote_contract_proposal_data */][1/* votes */],
                false,
                p3/* target_bounty_exchanges_depth-data */,
                v4/* data */[2/* vote_contract_proposal_data */][2/* sender_accounts */]
            );
        }

        if(p1/* consensus_type_data */[ 14 /* exit_contract */ ] != 0){
            /* if one of the actions involves an exit contract */

            f267/* execute_enter_extend_exit_contract_work */(
                v4/* data */[3/* exit_contract_data */],
                0/* sender_account */,
                11/* exit_contract */
            );
        }

        if(p1/* consensus_type_data */[ 15 /* force_exit_contract */ ] != 0){
            /* if one of the actions involves a force exit contract */

            f267/* execute_enter_extend_exit_contract_work */(
                v4/* data */[4/* exit_contract_data */],
                0/* sender_account */,
                18/* <18>contract_force_exit_accounts */
            );
        }

    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* record_voter_work */
    function f194(
        uint256 p1/* contract_id */, 
        uint256 p2/* sender_acc_id */, 
        bool p3/* record_target_payer_for_buy */, 
        uint256 p4/* proposal_id */,
        uint256 p5/* contracts_auto_wait */,
        uint256 p6/* allow_external_buy_proposals */
    ) external f154(msg.sender) {
        /* sets a new proposals data, such as voter data if the contracts auto wait value is on */

        G32.f119/* record_voter_work */(p1/* contract_id */, p2/* sender_acc_id */, p3/* record_target_payer_for_buy */, p4/* proposal_id */, p5/* contracts_auto_wait */, gv4/* num_data */, p6/* allow_external_buy_proposals */);
        /* calls the record voter work function in the G32 library function */
    }


    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* get_total_consensus_data(0) | contract_voter_count_data(2) | account_entry_expiry_time(3) | entry_time_to_expiry(4) | total_consensus_data_as_percentages(5) */
    function f266(
        uint256[] memory p1/* targets */, 
        uint256[][] memory p2/* voter_accounts */, 
        uint256 p3/* action */
    ) external view returns(uint256[][] memory v1/* data */){
        /* returns the yes, no and wait data or the votes cast by specified accounts for each consensus object specified */
        
        if(p3/* action */ == 5/* total_consensus_data_as_percentages */){
            /* if the action is get consensus data as percentages */

            uint256[][] memory v2/* raw_vote_data */ = G32./* get_total_consensus_data_account_votes_data */f266(p1/* consensus_targets */, p2/* voter_accounts */, 0/* get_total_consensus_data */, gv4/* num_data */);
            /* get the raw vote data using the get_total_consensus_data action zero */

            v1/* data */ = F32./* get_total_consensus_data_as_percentages */f278(v2/* raw_vote_data */);
            /* set the return value as the percentage data from the get_total_consensus_data_as_percentages function in the E32 library */
        }
        else{
            v1/* data */ =  G32./* get_total_consensus_data_account_votes_data */f266(p1/* consensus_targets */, p2/* voter_accounts */, p3/* action */, gv4/* num_data */);
            /* set the return data from the get_total_consensus_data_account_votes_data function in the G32 library */
        }
    }


    /* get_account_votes_data */
    function f237(
        uint256[] memory p1/* consensus_targets */, 
        uint256[][] calldata p2/* voter_accounts */
    ) external view returns(uint256[][] memory v1/* vote_data */){
        /* returns the votes cast by specified accounts for specified proposal targets. For each proposal, a list of accounts should be passed. */
        
        v1/* total_vote_data */ = new uint256[][](p1.length);
        /* initialize the return variable as a new array with the number of targets as its length */

        for (uint256 t = 0; t < p1/* consensus_targets */.length; t++) {
            /* for each id target passed */

            uint256 v2/* number_of_accounts */ = p2/* voter_accounts */[t].length;
            /* record the number of accounts specified for the specific target proposal */

            uint256[] memory v3/* account_vote_data */ = new uint256[](v2);
            /* initialize a new array to contain the account votes */

            for (uint256 a = 0; a < p2/* voter_accounts */[t].length; a++) {
                /* for each account passed */

                mapping(uint256 => uint256) storage v4/* target_vote_data */ = gv4/* num_data */.int_int_int[ p1/* consensus_targets */[t] ][ 3 /* account_votes */ ];
                /* initialize a storage mapping that points to the consensus' accounts vote data */

                v3/* account_vote_data */[a] = v4/* target_vote_data */[p2/* voter_accounts */[t][a]];
            }

            v1/* total_vote_data */[t] = v3/* account_vote_data */;
        }
    }//-----TEST_OK-----

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

    // function func() external f154(msg.sender) {

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

    /* set_int_int_int */
    // function f1392(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ p1/* _ids */[t][1] /* value */ ][ p1/* _ids */[t][2] /* account */ ] = p1/* _ids */[t][3];
    //     }
    // }

    /* delete_int_int_int */
    // function f1393(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ p1/* _ids */[t][1] /* value */ ][ p1/* _ids */[t][2] /* account */ ] = 0;
    //     }
    // }


    // uint256[][3] v4e/* data */;
    // function f2671t() public view returns(uint256[][3] memory){
    //     return v4e/* data */;
    // }

}
