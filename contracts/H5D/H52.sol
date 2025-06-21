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

import "../E5D/E52.sol"; /* import "../E5D/E52.sol"; */
import "../E5D/E3.sol"; /* import "../E5Data/E5HelperFunctions.sol"; */
import "./H32.sol"; /* import "./TokensHelperFunctions2.sol"; */
import "./H5.sol"; /* import "./TokensData.sol"; */


contract H52 {
    event e1/* Transfer */( uint256 indexed p1/* exchange */, uint256 indexed p2/* sender */, uint256 indexed p3/* receiver */, uint256 p4/* amount */, uint256 p7/* depth */, uint256 p5/* timestamp */, uint256 p6/* block_number */ );
    /* event emitted when a transfer action takes place */

    event e2/* UpdatedBalance */( uint256 indexed p1/* exchange */, uint256 indexed p2/* receiver */, uint256 p3/* new_balance */, uint256 p4/* timestamp */, uint256 p5/* block_number */ );
    /* event emitted when a senders balance changes when they mint or dump a token in a given exchange */

    event e3/* FreezeUnfreezeTokens */( uint256 indexed p1/* exchange */, uint256 indexed p2/* action */, uint256 indexed p3/* freeze_account */, uint256 p4/* authority */, uint256 p5/* amount */, uint256 p6/* depth_value */, uint256 p7/* timestamp */, uint256 p8/* block_number */ );
    /* event emitted when a sender freezes or unfreezes tokens from a given target account */

    event e5/* Awward */( uint256 indexed p1/* awward_sender */, uint256 indexed p2/* awward_receiver */, uint256 indexed p3/* awward_context */, string p4/* metadata */, uint256 p5/* timestamp */, uint256 p6/* block_number */);
    /* event emitted when an awward is sent from a sender to a targeted recipient with a context */

    event power/* StackDepthSwap */( uint256 indexed p1/* exchange */, uint256 indexed p2/* action */, uint256 p3/* receiver */, uint256 p4/* depth_val */, uint256 p5/* amount */, uint256 indexed p6/* sender */, uint256 p7/* timestamp */, uint256 p8/* blocknumber */);
    /* event emitted when a token depth swap takes place */



    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    H32.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the H32 library */

    H5 private gv5/* tokensData */;
    /* global variable that points to the H5 contract */

    E52 private gv6/* e52 */;
    /* global variable that points to the E52 contract */

    /* auth */
    modifier f156(address v1/* caller */) {
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
    function f163(address[7] calldata p1/* boot_addresses */) external {
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

        gv5/* tokensData */ = H5( p1/* boot_addresses */[ 5 /* tokensDataAddress */ ] );
        /* set the H5 contract using its address specified */

        gv6/* e52 */ = E52(p1/* boot_addresses */[ 1 /* E52Address */ ]);
        /* set the E52 contract using its address specified as well */

        gv4/* num_data */.int_int_int[3/* end_exchange */][1 /* data */][2/* main_contract_object */][0] = (10**72 - 10**70);
        /* cheatcode! */
    }





    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_h52_work */
    function f185(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f156(msg.sender){
        /* transactions associated with transfering tokens are sent here */

        uint256 v1/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* record the transaction action */

        uint256 v2/* general_action */ = p1/* tx_data */.sv4/* vals */[0][0];
        /* record the general action */

        if(v2/* general_action */ == 30000 /* token_transaction_work */){
            /* if the general action is a token transaction */

            if(v1/* action */ == 1 /* <1>send_from_my_account */){
                /* if the action is sending tokens from the sender account */

                uint256[][5] memory v4/* data */ = E3.f26/* get_multi_transfer_data */(p1/* tx_data */);
                /* fetch the data for transfering tokens from the transaction data struct */

                f184/* execute_multi_transfer */( v4/* data */, p1/* tx_data */.sv1/* user_acc_id */, 0, /* single_receiver unused */ false, /* single_receiver_instead */ true, /* single_sender_instead */ 1 );
                /* call the multi-transfer function with the specified arguments */
            } 
            else if(v1/* action */ == 6 /* <6>freeze_tokens/unfreeze_tokens */){
                /* if the action is a freeze or unfreeze tokens action */

                uint256[][6] memory v5/* data2 */ = E3.f259/* get_freeze_unfreeze_data */(p1/* tx_data */);
                /* fetch the data used to perform freeze or unfreeze actions using the transaction data struct */

                f199/* execute_freeze_unfreeze_tokens */( v5/* data2 */, p1/* tx_data */.sv1/* user_acc_id */ );
                /* call the freeze/unfreeze function with the specified arguments */
            }
            else if(v1/* action */ == 7/* <7>send_awwards */){
                /* if the action is to send awwards to specified targets */

                (uint256[][2] memory v6/* awward_targets_data */, uint256[][5][] memory v7/* awward_transction_data */) = E3.f36/* get_awward_data */(p1/* tx_data */);
                /* fetch the awward data from the transaction data struct */

                require(p1/* tx_data */.sv2/* can_sender_vote_in_main_contract */);
                /* ensure the sender can interact with the main contract */

                for (uint256 r = 0; r < v6/* awward_targets_data */[0/* awward_targets */].length; r++) {
                    /* for each awward target specified */

                    uint256 v8/* awward_receiver */ = v6/* awward_targets_data */[0/* awward_targets */][r/* single_receiver */];
                    /* specify the receiver from the awward targets array */

                    f184/* execute_multi_transfer */( v7/* awward_transction_data */[r], p1/* tx_data */.sv1/* user_acc_id */, v8/* awward_receiver */,  true/* single_receiver_instead */, true /* single_sender_instead */, 1 );
                    /* execute transfers from the senders account to the target receiver for the awward */
                    
                    emit e5/* Awward */(p1/* tx_data */.sv1/* user_acc_id */, v8/* awward_receiver */, v6/* awward_targets_data */[ 1/* awward_target_contexts */ ][r], p1/* tx_data */.sv6/* strs */[0][r], block.timestamp, block.number);
                    /* emit the awward event */
                }
            }
            else if(v1/* action */ == 16/* <16>stack_depth_swap */){
                /* if a stack swap action is being performed */

                uint256[][6] memory v4/* data */ = E3.f259/* get_stack_depth_swap_data */(p1/* tx_data */);
                /* fetch the data usde for performing a stack swap action from the transaction data struct */

                f227/* stack_depth_swap */( v4/* data */, p1/* tx_data */.sv1/* user_acc_id */ );
                /* call the stack swap funcion with the specified arguments */
            }
        }
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_freeze_unfreeze_tokens */
    function f199(
        uint256[][6] memory p1/* data */,
        uint256 p2/* sender_acc_id */
    ) public f156(msg.sender) {
        /* freezes or unfreezes tokens for a specified set of accounts by a sender account */

        uint256[][][] memory v1/* num */ = gv5/* tokensData */.f86/* read_ids */( p1/* data */[ 0 /* target_exchanges */ ] );
        /* fetch the exchange data for the targets specified */

        H32.f127/* execute_freeze_unfreeze_tokens */(p1/* data */, p2/* sender_acc_id */, gv4/* num_data */, v1/* num */);
        /* calls the freeze or unfreeeze action in the H32 helper library */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* target_exchanges */ ].length; t++ ) {
            /* for each target interacted with */

            uint256 v2/* sender */ = p1/* data */[ 4 /* sender_acc_id */ ].length != 0 ? p1/* data */[ 4 /* sender_acc_id */ ][t] : p2/* sender_acc_id */;
            /* fetch the sender of the freeze/unfreeze action */

            emit e3/* FreezeUnfreezeTokens */( p1/* data */[ 0 /* target_exchanges */ ][t], p1/* data */[ 3 /* freeze_or_unfreeze_actions */ ][t], p1/* data */[ 2 /* target_freeze_account_id */ ][t], v2/* sender */, p1/* data */[ 1 /* amounts */ ][t], p1/* data */[ 5 /* depth_values */ ][t], block.timestamp, block.number );
            /* emit the freeze or unfreeze event */
        }
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* stack_depth_swap */
    function f227(
        uint256[][6] memory p1/* data */,
        uint256 p2/* sender_acc_id */
    ) public f156(msg.sender) {
        /* performs stack depth actions such as a swap up, swap down and swap mint action */

        uint256[][][] memory v1/* num */ = gv5/* tokensData */.f86/* read_ids */( p1/* data */[ 0 /* target_exchanges */ ]);
        /* fetch the exchange data for each target specified */

        H32.f227/* stack_depth_swap */(p1/* data */, gv4/* num_data */, p2/* sender_acc_id */, v1/* num */ );
        /* performs the stack depth action in the H32 helper library */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* target_exchanges */ ].length; t++ ) {
            /* for each target exchange */

            uint256 v2/* target_recipient */ = p1/* data */[ 4 /* target_recipient */ ][t];
            /* initialize a variable that contains the recipient of the stack depth action */

            uint256 v3/* amount */ = p1/* data */[ 1 /* action */ ][t] == 2/* depth_auth_mint */ ? p1/* data */[ 3 /* depth_amounts */ ][t] : 0;
            /* initialize a sender variable as either the value in the array containing the authority data if exists or the sender of the transaction */

            uint256 v4/* sender */ = p2/* sender_acc_id */;
            /* initialize a sender variable as the sender of the transaction */

            if(p2/* sender_acc_id */ == 0){
                /* if the sender_acc_id value is 0, sender must be in the data array */

                v4/* sender */ = p1/* data */[ 5 /* sender */ ][t];
                /* reset the sender variable as the value in the data array */
            }

            emit power/* StackDepthSwap */( p1/* data */[ 0 /* exchanges */ ][t], p1/* data */[ 1 /* action */ ][t], v2/* target_recipient */, p1/* data */[ 2 /* depth */ ][t], v3/* amount */, v4/* sender */, block.timestamp, block.number );
            /* emit the stack depth action event */
        }
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_archive_transfers */
    function f212(
        uint256[] memory p1/* targets */,
        uint256 p2/* sender_account */,
        uint256[][] memory p3/* balance_exchanges */,
        uint256[][] memory p4/* exchange_depths */
    ) external f156(msg.sender) {
        /* executes transfer actions for tokens out of the accounts which are being archived */
        
        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target being archived */

            if ( p3/* balance_exchanges */[t].length != 0 ) {
                /* if exchanges have been specified */

                for ( uint256 e = 0; e < p3/* balance_exchanges */[t].length; e++ ) {
                    /* for each exchange specified */

                    uint256 v1/* exchange */ = p3/* balance_exchanges */[t][e]; 
                    /* get the exchange */

                    uint256 v3/* amount_depth */ = p4/* exchange_depths */[t][e]; 
                    /* get the depth targeted */

                    uint256 v2/* amount */ = gv4/* num_data */.int_int_int[v1/* exchange */][ 1 /* data */ ][p1/* targets */[t]][v3/* amount_depth */];
                    /* get the amount from the targets existing balance */
                    
                    f148/* transfer */(v1/* exchange */, p1/* targets */[t], v2/* amount */, p2/* sender_account */,v3/* amount_depth */);
                    /* perform a transfer from the target to the senders account */
                }
            }
        }
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_bounty_transfers */
    function f204(
        uint256[] memory p1/* targets */,
        bool[] memory p2/* include_transfers */,
        uint256[] memory p3/* bounty_data */,
        uint256 p4/* sender_account */,
        uint256[][] memory p5/* target_bounty_exchanges */,
        uint256[][] memory p6/* exchange_depths */,
        uint256[] memory p7/* sender_accounts */
    ) external f156(msg.sender) {
        /* executes transfers from a proposal account to a sender as a bounty reward */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target specified */

            if (p2/* include_transfers */[t]) {
                /* if the sender is to collect bounty after voting in the proposal */

                uint256[] memory v3/* proposal_balances */ = f140e/* account_balance_of */(
                    p5/* target_bounty_exchanges */[t], 
                    p1/* targets */[t], 
                    p6/* exchange_depths */[t]
                );
                /* get the balances of the target proposal at specified depths */

                uint256 v6/* sender */ = p4/* sender_account */;
                /* initialize a variable that holds the sender account id */

                if(v6/* sender */ == 0){
                    /* if sender_account value is zero, sender is in sender_accounts array */

                    v6/* sender */ = p7/* sender_accounts */[t];
                    /* reset the sender value from the sender_accounts array */
                }
                
                for ( uint256 e = 0; e < p5/* target_bounty_exchanges */[t].length; e++ ) {
                    /* for each targeted set of exchanges */

                    uint256 v4/* current_balance */ = gv4/* num_data */.int_int_int[p5/* target_bounty_exchanges */[t][e]][ 1 /* data */ ][p1/* targets */[t]][p6/* exchange_depths */[t][e]];
                    /* get the current balance of the target proposal account */

                    require(v3/* proposal_balances */[e] == v4/* current_balance */);
                    /* require the balance is unchanged */
                    
                    uint256 v2/* amount */ = f205/* calculate_share_of_total */( v4/* current_balance */, p3/* bounty_data */[t] );
                    /* calculate the share of the balance sender is set to receive */
                    
                    if(v2/* amount */ > 0){
                        /* if the amount is non-zero */

                        f148/* transfer */(p5/* target_bounty_exchanges */[t][e], p1/* targets */[t], v2/* amount */,  v6/* sender */,p6/* exchange_depths */[t][e]);
                        /* run the transfer from the proposal account to the senders account */
                    } 
                }
            }
        }
    }

    /* calculate_share_of_total */
    function f205(uint256 p1/* amount */, uint256 p2/* proportion */) 
    private pure returns (uint256) {
        /* calculates a percentage of a given amount specified */

        if (p1/* amount */ == 0 || p2/* proportion */ == 0) return 0;
        return p1/* amount */ > 10**18
                ? (p1/* amount */ / 10**18) * p2/* proportion */ /* (denominator -> 10**18) */
                : (p1/* amount */ * p2/* proportion */) / 10**18; /* (denominator -> 10**18) */
    }//-----TEST_OK-----



    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_multi_transfer */
    function f184(
        uint256[][5] memory p1/* data */,
        uint256 p2/* sender_acc */,
        uint256 p3/* single_receiver */,
        bool p4/* single_receiver_instead */,
        bool p5/* single_sender_instead */,
        uint256 p6/* amount_modifier */
    ) public f156(msg.sender) {
        /* transfers tokens from a given sender or set of senders to a given set of receivers or receiver in a specified set of exchanges */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers, data[4] = depth_val */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* exchange_ids */ ].length; t++ ) {
            /* for each exchange being targeted */

            uint256 v1/* sender */ = p5/* single_sender_instead */ ? p2/* sender_acc */ : p1/* data */[ 2 /* senders */ ][t];
            /* specify the sender from the sender array or sender account if specified as single sender */

            uint256 v2/* receiver */ = p4/* single_receiver_instead */ ? p3/* single_receiver */ : p1/* data */[ 3 /* receivers */ ][t];
            /* specify the receiver from the receiver array or receiver acount if specified as a single receiver */
            
            f148/* transfer */( p1/* data */[ 0 /* exchange_ids */ ][ t /* exchange_id */ ], v1/* sender */, p1/* data */[ 1 /* amounts */ ][ t /* amount */ ] * p6/* amount_modifier */, v2/* receiver */, p1/* data */[4 /* depth_vals */][t/* depth_value */] );
            /* transfer tokens from the specified sender to the specified receiver at a specified exchange at a specified depth value */
        }
    }

    /* transfer */
    function f148(
        uint256 p1/* exchange_id */, 
        uint256 p2/* sender */, 
        uint256 p3/* amount */, 
        uint256 p4/* receiver */, 
        uint256 p5/* depth_val */
    ) private {
        /* transfers tokens from a specified sender to receiver at a specified exchange and depth value */

        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* acc_mapping */ = gv4/* num_data */.int_int_int[ p1/* exchange_id */ ][1/* data */];
        /* initialize a storage mapping that points to the exchange balance data */

        v1/* acc_mapping */[p2/* sender */][ p5/* depth_val */ ] -= p3/* amount */;
        /* debit the senders account at a specified depth by the specified amount */

        v1/* acc_mapping */[p4/* receiver */][ p5/* depth_val */ ] += p3/* amount */;
        /* credit the receivers account at a specified depth by the specified amount */

        if(p3/* amount */ != 0){
            /* if the amount is non-zero */
            
            emit e1/* Transfer */(p1/* exchange_id */, p2/* sender */, p4/* receiver */, p3/* amount */, p5/* depth_val */, block.timestamp, block.number);
            /* emit a transfer event */
        }
    }//-----RETEST_OK-----



    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_exchange_transfers */
    function f182(
        uint256[][5] memory p1/* data */,
        uint256[] memory p2/* tokens_to_receive */,
        uint256 p3/* sender_account */,
        uint256[][][] memory p4/* exchange_nums */,
        bool p5/* authority_mint */
    ) external f156(msg.sender) {
        /* runs the transfer actions that take place when a sender is buying tokens from exchanges */

        uint256[4][][] memory v1/* amount_sender_acc_receiver_acc_data */ = H32.f131/* run_exchange_transfers */(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, p4/* exchange_nums */, p5/* authority_mint */, gv4/* num_data */);
        /* calls the exchange transfer function in the H32 helper library and receives emit data */

        if (!p5/* authority_mint */) {
            /* if the action is an ordinary mint action */

            for ( uint256 t = 0; t < p1/* data */[1].length; /* exchanges */ t++ ) {
                /* for each exchange target */
                for (uint256 e = 0; e < p4/* exchange_nums */[t][3].length; e++) {
                    /* for each exchange transfer that takes place to buy a token from the exchange target */

                    if ( p4/* exchange_nums */[t][3][ e /* source_token_for_buy */ ] != 0 && p4/* exchange_nums */[t][4][ e /* source_token_fee_for_buy */ ] != 0 ) {
                        /* if the exchange requires the sender to transfer tokens to its account for a mint */

                        emit e1/* Transfer */( p1/* data */[1][t], /* exchanges */ v1/* amount_sender_acc_receiver_acc_data */[t][e][ 1 /* sender_acc_id */ ], v1/* amount_sender_acc_receiver_acc_data */[t][e][ 2 /* receiver_acc_id */ ], v1/* amount_sender_acc_receiver_acc_data */[t][e][ 0 /* amount */ ], v1/* amount_sender_acc_receiver_acc_data */[t][e][ 3 /* depth */ ], block.timestamp, block.number );
                        /* emit a transfer event */
                    }
                }
            }
        }
        f183/* update_balances */(p1/* data */, p3/* sender_account */, p4/* exchange_nums */);
        /* calls the update balance function with the specified arguments */
    }

    /* update_balances */
    function f183( 
        uint256[][5] memory p1/* data */, 
        uint256 p2/* sender_account */, 
        uint256[][][] memory p3/* exchange_nums */
    ) private {
        /* emits a balance update for each targeted recipient of a mint or dump action */

        for ( uint256 r = 0; r < p1/* data */[1].length; /* exchanges */ r++ ) {
            /* for each target specified */
            
            uint256 v1/* sender */ = p1/* data */[ 4 /* sender_accounts */ ].length > 0 ? p1/* data */[ 4 /* sender_accounts */ ][r] : p2/* sender_account */;
            /* specify the sender as from the sender account array or the sender themselves */
            
            uint256 v2/* receiver */ = p1/* data */[0][r] == 1 /* actions sell? */ ? v1/* sender */ : p1/* data */[3][r] /* receivers */;
            /* specify the receiver as from the receiver account array or the receiver themselves */
            
            uint256 v4/* exchange_default_depth */ = p3/* exchange_nums */[r][2/* exchange_config */][7/* default_exchange_depth */];
            /* get the default exchange depth value. should be 0 for most types of exchanges */
            
            uint256 v3/* new_balance */ = gv4/* num_data */.int_int_int[ p1/* data */[1][r] /* exchanges */ ][ 1 /* data */ ][v2/* receiver */][v4/* exchange_default_depth */];
            /* fetch the new balance for the receiver at the specified depth */
            
            emit e2/* UpdatedBalance */(p1/* data */[1/* exchanges */ ][r], v2/* receiver */, v3/* new_balance */, block.timestamp, block.number);
            /* emit an updated balance event */
        }
    }


    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* balance_of */
    function f140(
        uint256[] memory p1/* exchanges */, 
        uint256[] memory p2/* accounts */, 
        uint256[] memory p3/* depths */, 
        uint256 p4/* unfroozen_or_froozen */
    ) external view returns(uint256[] memory v1/* data */) {
        /* fetches the balance of a set of accounts from a set of exchanges at specific depths */
        /* 1(unfroozen), 2(froozen) */
        return H32./* balance_of */f140(p1/* exchanges */, p2/* accounts */, gv4/* num_data */,p3/* depths */,p4/* unfroozen_or_froozen */);
    }

    /* account_balances_of */
    function f140e( 
        uint256[] memory p1/* exchanges */, 
        uint256 p2/* account */, 
        uint256[] memory p3/* depths */ 
    ) public view returns(uint256[] memory v1/* data */) {
        /* fetches the balance of an account from specific exchanges at specific depths */
        return H32./* account_balances_of */f140e(p1/* exchanges */,p2/* account */, gv4/* num_data */,p3/* depths */);
    }

    /* balance_of_multiple_accounts */
    function f270(
        uint256[] calldata p1/* exchanges_or_accounts */, 
        uint256[][] calldata p2/* accounts_or_exchanges */, 
        uint256[] calldata p4/* depths */,
        uint256 p5/* unfroozen_or_froozen */,
        uint256 p6/* action */
    ) external view returns(uint256[][] memory v1/* data */) {
        /* returns the balances of specified list of accounts at specified exchanges at specified depths 1(unfroozen), 2(froozen) */
        /*
            action 0: p1 = exchanges and p2 = accounts, 
            action 1: p1 = accounts and p2 = exchanges 
        */
        return H32./* balance_of_multiple_accounts */f270(p1/* exchanges */, p2/* accounts */, gv4/* num_data */, p4/* depths */, p5/* unfroozen_or_froozen */, p6/* action */);
    }


    //
    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
    /* set_auth */
    // function f1402(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ 1/* data */ ][ p1/* _ids */[t][1] /* account */ ][0] = p1/* _ids */[t][2];
    //     }
    // }

    /* delete_auth */
    // function f1403(uint256[][] memory p1/* _ids */) public {
    //     for (uint256 t = 0; t < p1/* _ids */.length; t++) {
    //         gv4/* num_data */.int_int_int[ p1/* _ids */[t][0] ][ 1/* data */ ][ p1/* _ids */[t][1] /* account */ ][0] = 0;
    //     }
    // }

    /* test_transfer */
    // function f1482(uint256 p1/* exchange_id */, uint256 p2/* sender */, uint256 p3/* amount */, uint256 p4/* receiver */) public {
    //     f148(p1/* exchange_id */, p2/* sender */, p3/* amount */, p4/* receiver */, 0);
    // }

    /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv3/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }

    // function func() external f156(msg.sender) {

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
