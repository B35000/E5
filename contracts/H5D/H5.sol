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

import "./H52.sol"; /* import "./TokensData2.sol"; */
import "./H3.sol"; /* import "./TokensHelperFunctions.sol"; */
// import "./H32.sol"; /* import "./TokensHelperFunctions.sol"; */

import "../E5D/E52.sol"; /* import "../E5D/E52.sol"; */
import "../E5D/E3.sol"; /* import "../E5Data/E5HelperFunctions.sol"; */
import "../E5D/E32.sol"; /* import "../E5Data/E5HelperFunctions2.sol"; */
import "../E5D/E33.sol"; /* import "../E5Data/E5HelperFunctions3.sol"; */
// import "../E5D/E34.sol"; /* import "../E5Data/E5HelperFunctions4.sol"; */

import "../F5D/F33.sol"; /* import "../F5Data/F5HelperFunctions3.sol"; */


contract H5 {
    event e1/* UpdateExchangeRatios */(uint256 indexed p1/* exchange */, uint256 indexed p2/* action */, uint256 indexed p3/* sender_account */, uint256 p4/* token_exchange_liquidity */, uint256 p5/* updated_exchange_ratio_x */, uint256 p6/* updated_exchange_ratio_y */, uint256 p7/* parent_tokens_balance */, uint256 p8/* amount */, uint256 p9/* timestamp */, uint256 p10/* block_number */);
    /* event emitted when an exchange's exchange-ratios change when a swap action takes place. used by capped tokens. */

    event e2/* UpdateProportionRatios */( uint256 indexed p1/* exchange */, uint256 p2/* new_active_limit */, uint256 p3/* tokens_to_receive */, uint256 p4/* block_number */, uint256 p5/* timestamp */ );
    /* event emitted when an exchange's reduction proportion ratios are change when a mint action takes place. used by uncapped tokens like spend */
    
    event e3/* ModifyExchange */( uint256 indexed p1/* exchange */, uint256 p2/* sender_account */, uint256 p3/* config_array_pos */, uint256 p4/* config_item_pos */, uint256 p5/* new_config_item */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event emitted when an exchange's configuration is modified or changed */


    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    H3.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the H3 library */

    H52 private gv5/* tokensData2 */;
    /* global variable that points to the H52 contract */

    E52 private gv6/* e52 */;
    /* global variable that points to the E52 contract */

    /* auth */
    modifier f155(address v1/* caller */) {
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
    function f162(
        address[7] calldata p1/* boot_addresses */,
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
        gv6/* e52 */ = E52(p1/* boot_addresses */[ 1 /* E52Address */ ]);
        /* set the E52 contract using its address specified */

        gv5/* tokensData2 */ = H52( p1/* boot_addresses */[ 6 /* tokensData2Address */ ] );
        /* set the H52 contract using its address specified */

        H3.f121/* boot */(p2/* boot_data */, p3/* boot_id_data_type_data */, gv4/* num_data */);
        /* call the boot function in the H3 helper library */
    }

    
    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* make_token_exchange */
    function f176(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f155(msg.sender) {
        /* creates a new token exchange */

        uint256 v1/* obj_id */ = p1/* tx_data */.sv3/* temp_transaction_data */[p1/* tx_data */.t];
        /* get the new token exchanges object id */
            
        f177/* record_new_objects_data */(v1/* obj_id */, p1/* tx_data */.sv4/* vals */, p1/* tx_data */.sv1/* user_acc_id */, p1/* tx_data */.sv3/* temp_transaction_data */);
        /* calls the record object data function with the specified arguments */

        E33.f66/* run_token_exchange_checkers */(f85/* read_id */(v1/* obj_id */));
        /* calls the token exchange checker function in the E33 helper library */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_token_transaction */
    function f179(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f155(msg.sender)
    returns (uint256[3] memory v1/* buy_sell_data */){
        /* transactions associated with interacting with a token exchange are sent here */

        uint256 v2/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* get the transaction action  */

        uint256 v3/* general_action */ = p1/* tx_data */.sv4/* vals */[0][0];
        /* record the general action */

        if(v3/* general_action */ == 20000 /* mod_work */){
            /* if the general action is a mod action */

            if(v2/* action */ == 3 /* <3>modify_token_exchange */ ){
                /* if the action is a modify exchange action */

                uint256[][5] memory v4/* target_id_data */ = E3.f21/* get_primary_secondary_target_data */(p1/* tx_data */);
                /* fetch the data used for modifying a token exchange using the transaction data struct */

                f198/* modify_token_exchange */(v4/* target_id_data */, p1/* tx_data */.sv1/* user_acc_id */);
                /* call the modify token exchange function with the supplied arguments */
            }
        }
        else if(v3/* general_action */ == 30000 /* token_transaction */ ){
            /* if the action is a token transaction action */
            
            if( v2/* action */ == 9 /* auth_mint */ || v2/* action */ == 8 /* <8>buy_tokens/sell_tokens */){
                /* if the action is an auth mint or buy/sell tokens */

                (uint256[][6] memory v5/* data2 */, uint256[4] memory v6/* user_data */, uint256[][2] memory v7/* bounds */) = E3.f28/* get_mint_tokens_data */(p1/* tx_data */, v2/* action */);
                /* get the data used for performing a mint action */

                if( v2/* action */ == 9 /* auth_mint */){
                    /* if the action is a mint action as an authority */

                    f180/* execute_buy_or_sell_tokens */( v5/* data2 */, v6/* user_data */, true/* authority_mint */,  v7/* bounds */ );
                    /* calls the buy sell tokens function with the supplied data */
                }
                else if( v2/* action */ == 8 /* <8>buy_tokens/sell_tokens */ ){
                    /* if the action is an ordinary mint action */
                    
                    // gv6/* e52 */.f69/* ensure_interactibles */(v5/* data2 */[1/* exchanges */] , p1/* tx_data */.sv1/* user_acc_id */);
                    /* ensure sender can interact with the targeted exchanges */

                    /* buy_sell_data[external_amount,  receiver_acc_id,  new_msg_value] */
                    v1/* buy_sell_data */ = f180/* execute_buy_or_sell_tokens */(v5/* data2 */, v6/* user_data */, false/* authority_mint */, v7/* bounds */);
                    /* calls the buy sell tokens function */
                }
            }
            else if(v2/* action */ == 17 /* <17>exchange_transfer */){
                /* if the action is an exchange transfer action */

                uint256[][6] memory v8/* data2 */ = E3.f259/* get_exchange_transfer_data */(p1/* tx_data */); 
                /* get the data used for performing a exchange transfer action */

                f230/* run_exchange_transfer */(v8/* data2 */, p1/* tx_data */.sv1/* user_acc_id */);
                /* call the run exchange transfer function with the supplied arguments */
            }
        }
    }

    /* record_new_objects_data */
    function f177(
        uint256 p1/* new_obj_id */,
        uint256[][] memory p2/* t_vals */,
        uint256 p3/* user_acc_id */,
        uint256[] memory p4/* temp_transaction_data */
    ) private {
        /* records a new objects data in storage */
        /* 
            num: [<0>control:[<0>data_type, <1>moderator_accounts_count, <2>interactible_accounts_count], <1>moderator_accounts[<>account_id:(0 || 1)], <2>interactible_accounts[<>account_id:(0 || 1)] ]

            num_str_metas: [<0>all_data:[<0>num_group_length, <1>str_group_length], <1>num_data:[<n>pos_of_n_nums_count], <2>str_data:[<n>pos_of_n_str_count]]
        */
        uint256[][] memory v1/* new_obj_id_num_data */ = E32.f31/* get_new_objects_data */( p2/* t_vals */, p3/* user_acc_id */, p4/* temp_transaction_data */, 12 );
        /* gets the new token exchanges final data structure using the data passed and the temporary transaction data. 12 meaning 12 arrays have been specified. */

        H3.f120/* record_new_objects_data */(p1/* new_obj_id */, v1/* new_obj_id_num_data */, gv4/* num_data */);
        /* call the record object data function in the H3 helper library */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* modify_token_exchange */
    function f198(
        uint256[][5] memory p1/* data */,
        uint256 p2/* sender_account */
    ) public f155(msg.sender) {
        /* used to modify the configuration data for a given set of exchanges */

        H3.f122/* modify_token_exchange */(p1/* data */, gv4/* num_data */, p2/* sender_account */);
        /* calls the modify exchange function in the H3 helper library */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each target spefified */

            uint256 v1/* sender */ = p1/* data */[ 4 /* authority */ ].length != 0 ? p1/* data */[ 4 /* authority */ ][t] : p2/* sender_account */;
            /* initialize a sender variable from the authority array if it exists or the sender account otherwise */

            emit e3/* ModifyExchange */( p1/* data */[ 0 /* targets */ ][t], v1/* sender */, p1/* data */[ 1 /* target_array_pos */ ][t], p1/* data */[ 2 /* target_array_items */ ][t], p1/* data */[ 3 /* new_items */ ][t], block.timestamp, block.number );
            /* emit a modify event */
        }

        E33.f64/* run_multiple_exchange_config_checkers */(f86/* read_ids */( p1/* data */[ 0 /* targets */ ] ) );
        /* ensure the exchange's new configurations are valid */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_exchange_transfer */
    function f230(
        uint256[][6] memory p1/* data */,
        uint256 p2/* initiator_account */
    ) public f155(msg.sender) {
        /* used to run transfers from an exchange account to the exchange's authority's account */

        H3.f83/* ensure_type_exchange */(p1/* data */[0/* exchanges */], gv4/* num_data */);
        /* ensure the supplied ids are the correct type */

        for (uint256 t = 0; t < p1/* data */[0/* exchanges */].length; t++) {
            /* for each exchange that has been targeted */

            uint256 v2/* initiator */ = p2/* initiator_account */ == 0 ? p1/* data */[4/* initiator_accounts */][t]: p2/* initiator_account */;
            /* initialize a new variable that holds the account that initiated the exchange transfer action */


            uint256 v3/* exchange_authority */ = gv4/* num_data */.num[ p1/* data */[0/* exchanges */][t] ][1/* exchange_config */][9 /* <9>exchange_authority */];
            /* get the specific exchange's authority were handling */

            uint256 v4/* unlocked_liquidity */ = gv4/* num_data */.num[ p1/* data */[0/* exchanges */][t] ][0][1 /* <1>unlocked_liquidity */];

            require(v3/* exchange_authority */ == v2/* initiator */ && v4/* unlocked_liquidity */ == 1);
            /* ensure the initiator to be the exchange authority of the exchange and the exchange's unlocked liquidity is turned on */
        }

        uint256[][5] memory v5/* data */  = [
            p1/* data */[5/* token_targets */], 
            p1/* data */[2/* amounts */], 
            p1/* data */[0/* exchanges */], 
            p1/* data */[1/* receivers */], 
            p1/* data */[3/* depths */]
        ];

        // uint256[][5] memory v1/* data */ = H3.f231/* run_exchange_transfer_checkers */(p1/* data */, p2/* initiator_account */, gv4/* num_data */);
        /* calls the run exchange transfer checkers for transfering tokens from exchange's account to specified recipients */

        gv5/* tokensData2 */.f184/* execute_multi_transfer */(v5/* data */, 0, 0, false, false, 1);
        /* call the multi-transfer function to transfer the specified amount of tokens from the targeted exchanges to the targeted recipients */
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_buy_or_sell_tokens */
    function f180(
        uint256[][6] memory p1/* data */,
        uint256[4] memory p2/* metas */,
        bool p3/* authority_mint */,
        uint256[][2] memory p4/* buy_sell_limits */
    ) public f155(msg.sender) returns (uint256[3] memory v1/* buy_sell_data */) {
        /* executes buy, sell or mint, dump actions for buying multiple tokens or selling multiple tokens */
        /* data[0] actions ,  data[1] exchanges , data[2] target_amounts , data[3] receivers, data[4] sender_accounts */
        
        /* metas[0] sender_account, metas[1] msg_value, metas[2] user_last_transaction_number, metas[3] user_last_entered_contracts_number */  

        gv6/* e52 */.f257/* ensure_interactibles_for_multiple_accounts */( p1/* data */[1/* exchanges */], p1/* data */[4/* sender_accounts */], p2/* metas */[0/* sender_account */] );
        /* ensure the sender or senders can interact with the exchange target */      
        
        uint256[][][] memory v2/* exchange_nums */ = H3.f123/* run_exchange_checkers */(p1/* data */, p2/* metas */, p3/* authority_mint */, gv4/* num_data */);
        /* get the exchange data for each target specified */

        uint256[] memory v7/* <15>temp_non_fungible_depth_token_transaction_class_array */ = new uint256[](v2.length);

        if (!p3/* authority_mint */) {
            /* if its an ordinary mint or dump action */

            (uint256[] memory v3/* updated_reduction_proportion_ratio_data */, uint256[] memory v8/* <15>temp_non_fungible_depth_token_transaction_class_array */) = F33.f40/* calculate_reduction_proportion_ratios */(v2/* exchange_nums */, p1/* data */[0/* actions */], block.number);
            /* update the proportions used for calculating the active mint limits */

            v7/* <15>temp_non_fungible_depth_token_transaction_class_array */ = v8/* <15>temp_non_fungible_depth_token_transaction_class_array */;
            
            v2/* exchange_nums */ = H3.f124/* update_reduction_proportion_ratios */( p1/* data */, v2/* exchange_nums */, gv4/* num_data */, v3/* updated_reduction_proportion_ratio_data */ );
            /* updates the new proportions used for calculating the active mint limit */

        }

        ( uint256[] memory v4/* tokens_to_receive */, uint256[2] memory v5/* external_amount_data */, uint256 v6/* new_msg_value */ ) = E32.f39/* calculate_tokens_to_receive */( p1/* data */, v2/* exchange_nums */, p2/* metas */[ 1 /* msg_value */ ], p3/* authority_mint */, p4/* buy_sell_limits */ );
        /* calculates the tokens the receiver is set to receive for each target exchange */

        f181/* update_exchange_ratios */( p1/* data */, v4/* tokens_to_receive */, p2/* metas */[ 0 /* sender_account */ ], v7/* <15>temp_non_fungible_depth_token_transaction_class_array */);
        /* updates the exchange ratio data */

        if (!p3/* authority_mint */) {
            /* if the action is an ordinary mint action */
            f149/* update_total_minted_for_current_block */(p1/* data */, v4/* tokens_to_receive */);
            /* calls the update total minted for current block data */
        }

        gv5/* tokensData2 */.f182/* run_exchange_transfers */(p1/* data */, v4/* tokens_to_receive */, p2/* metas */[ 0 /* sender_account */ ], v2/* exchange_nums */, p3/* authority_mint */);
        /* calls the exchange transfers in the H52 contract */

        if ( v5/* external_amount_data */[ 0 /* external_amount */ ] != 0 ) {
            /* if ether is set to be updated in the senders withdraw balance */

            v1/* buy_sell_data */[0/* external_amount */] = v5/* external_amount_data */[ 0 /* external_amount */ ];
            /* set the new external amount set to be received */

            v1/* buy_sell_data */[1/* receiver_acc_id */] = v5/* external_amount_data */[ 1 /* receiver_acc_id */ ];
            /* set the receiver account as well */
        }
        v1/* buy_sell_data */[2/* _msg_value */] = v6/* new_msg_value */;
        /* update the msg value in the buy sell data if consumed while buying end */
    }//-----TEST_OK-----

    /* update_total_minted_for_current_block */
    function f149(
        uint256[][6] memory p1/* data */,
        uint256[] memory p2/* tokens_to_receive */
    ) private {
        /* updates the total minted in the current block for uncapped tokens like spend */

        for ( uint256 t = 0; t < p1/* data */[1].length; /* exchanges */ t++ ) {
            /* for each target specified */

            if ( p1/* data */[0/* actions */][t] == 0 /* buy? */ ) {
                /* if the action is a buy action */

                if ( gv4/* num_data */.num[ p1/* data */[ 1 /* exchanges */ ][t] ][1][ 1 /* block_limit */ ] != 0 ) {
                    /* if the block limit is defined */

                    mapping(uint256 => uint256) storage v1/* exchange_ratio_values */ = gv4/* num_data */.num[ p1/* data */[1][t] /* exchanges */ /* <1>exchange_id */ ][2];
                    /* initialize a storage mapping that points to the exchanges ratio configuration */

                    if ( v1/* exchange_ratio_values */[ 5 /* <5>active_mint_block */ ] != block.number ) {
                        /* if its a new block */

                        v1/* exchange_ratio_values */[ 4 /* <4>current_block_mint_total */ ] = p2/* tokens_to_receive */[t];
                        /* set the current block mint supply to the tokens received */

                        v1/* exchange_ratio_values */[ 5 /* <5>active_mint_block */ ] = block.number;
                        /* set the new block as the active mint block */
                    } else {
                        v1/* exchange_ratio_values */[ 4 /* <4>current_block_mint_total */ ] += p2/* tokens_to_receive */[t];
                        /* incremebt the total minted in the current block by the tokens received */
                    }
                    //update current_block_mint_total value. If it's a new block, it restarts from 0. Then update the active mint block.

                    emit e2/* UpdateProportionRatios */( p1/* data */[1/* exchanges */][t], v1/* exchange_ratio_values */[ 6 /* <6>active_block_limit_reduction_proportion */ ], p2/* tokens_to_receive */[t], block.number, block.timestamp );
                    /* emit a update proportions event */
                }
            }
        }
    }//-----TEST_OK-----

    /* update_exchange_ratios */
    function f181(
        uint256[][6] memory p1/* data */,
        uint256[] memory p2/* tokens_to_receive */,
        uint256 p3/* sender_account */,
        uint256[] memory p4/* temp_non_fungible_depth_token_transaction_class_array */
    ) private {
        /* updates the exchange ratio data for each exchange targeted */

        H3.f125/* update_exchange_ratios */(p1/* data */, p2/* tokens_to_receive */, gv4/* num_data */);
        /* calls the update exchange ratio function in the H3 helper library */

        for ( uint256 r = 0; r < p1/* data */[1].length; /* exchanges */ r++ ) {
            /* for each target specified */

            mapping(uint256 => mapping(uint256 => uint256)) storage v1/* exchange */ = gv4/* num_data */.num[ p1/* data */[1][r] /* exchanges */ ];
            /* initialize a storage mapping that points to the exchanges data */

            uint256 v2/* sender */ = p1/* data */[ 4 /* sender_accounts */ ].length > 0 ? p1/* data */[ 4 /* sender_accounts */ ][r] : p3/* sender_account */;
            /* get the sender of the swap action from the sender accounts array or the sender of the transaction */

            if(p4/* temp_non_fungible_depth_token_transaction_class_array */[r] != 0){
                mapping(uint256 => uint256) storage v3/* exchanges_num_metas */ = gv4/* num_data */.num_metas[ p1/* data */[1][r] /* exchanges */ ];
                if ( p1/* data */[0/* actions */][r] == 1 /* sell? */ ) {
                    v3/* exchanges_num_metas */[p4/* temp_non_fungible_depth_token_transaction_class_array */[r]] -= p1/* data */[2][r]; /* target_amounts */
                }else{
                    v3/* exchanges_num_metas */[p4/* temp_non_fungible_depth_token_transaction_class_array */[r]] += p2/* tokens_to_receive */[r];
                }
            }
            

            emit e1/* UpdateExchangeRatios */( 
                p1/* data */[1][r], /* exchanges */ 
                p1/* data */[0][r], /* actions */ 
                v2/* sender */, 
                v1/* exchange */[2][ 2 /* <2>token_exchange_liquidity*/ ], 
                v1/* exchange */[2][ 0 /* <0>token_exchange_ratio_x */ ],
                v1/* exchange */[2][ 1 /* <1>token_exchange_ratio_y */ ],
                v1/* exchange */[2][ 3 /* <3>parent_tokens_balance */ ], 
                p2/* tokens_to_receive */[r], 
                block.timestamp, block.number);
            /* emit an update exchange ratio event */
        }
    }//-----TEST_OK-----


    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* get_consensus_spend_mint_trust_fees */
    function f88( uint256[][][] calldata p1/* target_nums */ ) 
    external view returns (uint256[][][2] memory) {
        /* gets the trust fee and trust fee recipient data used in consensus submit actions */
        return H3.f88/* get_consensus_spend_mint_trust_fees */(p1/* target_nums */, gv4/* num_data */);
    }



    /* read_ids */
    function f86(uint256[] memory p1/* _ids */) 
    public view returns (uint256[][][] memory) {
        /* reads a set of exchange data from specified ids */
        return H3.f86/* read_ids */(p1/* _ids */, gv4/* num_data */, p1/* _ids */);
    }

    /* read_id */
    function f85(uint256 p1/* _id */) 
    public view returns (uint256[][] memory) {
        /* reads an exchanges data from its id */
        return H3.f85/* read_id */(p1/* _id */, gv4/* num_data */, p1/* _id */);
    }



    /* scan_account_exchange_data */
    function f241(uint256[] memory p1/* accounts */, uint256[] memory p3/* exchanges */) 
    external view returns (uint256[4][] memory v1/* data */) {
        /* scans the int_int_int datastorage object for an accounts last_swap_block, last_swap_time, last_transaction_number and user_last_entered_contracts_number */
        // return H3./* scan_account_exchange_data */f241(p1, gv4/* num_data */, p2);

        v1/* data */ = new uint256[4][](p1.length);
        /* initialize the return variable as a new array whose length being the number of targets specified in the arguments */

        for (uint256 t = 0; t < p1/* accounts */.length; t++) {
            /* for each target specified */

            mapping(uint256 => uint256) storage v2/* pointer */ = gv4/* num_data */.int_int_int[p3/* exchanges */[t]][p1/* accounts */[t]];
            /* initialize a storage pointer variable that points to the accounts data in the targeted exchange including the last time they swapped, the last block they swapped and the number of transactions they had made during their last swap */

            v1/* data */[t] = [
                v2/* pointer */[ 0 /* last_swap_block */ ], 
                v2/* pointer */[ 1 /* last_swap_timestamp */ ], 
                v2/* pointer */[ 2 /* last_transaction_number */ ], 
                v2/* pointer */[ 3 /* user_last_entered_contracts_number */ ]
            ];
            /* set the data in the return data array */
        }
    }

    /* calculate_price_of_tokens */
    // function f245(
    //     uint256[] memory p1/* exchanges */,
    //     uint256[][] memory p2/* amounts */,
    //     uint256[] memory p3/* actions */
    // ) external view returns (uint256[][] memory v1/* price_data */){
    //     /* calculates the tokens to be received when buying or selling a set of tokens */

    //     uint256[][][] memory v2/* exchange_nums */ = f86/* read_ids */(p1/* exchanges */);
    //     /* initialize a variable containing the exchange data for each exchange specified */
        
    //     v1/* price_data */ = E34.f245/* calculate_price_of_tokens */(p1/* exchanges */, p2/* amounts */, p3/* actions */, v2/* exchange_nums */);
    //     /* set the result price data from the calculate price of tokens function from E32 helper library  in the return value */
    // }

    /* calculate_token_mint_limits */
    // function f247( uint256[] memory p1/* exchanges */ ) 
    // external view returns (uint256[] memory v1/* mint_limits */){
    //     /* calculates and returns the tokens set to be received when a mint action is sent at this specific time */

    //     uint256[][][] memory v2/* exchange_nums */ = f86/* read_ids */(p1/* exchanges */);
    //     /* initialize a variable containing the exchange data for each exchange specified */

    //     uint256[][5] memory v3/* mock_data */ = H32.f248/* set_up_mock_data */(p1/* exchanges */, v2/* exchange_nums */);

    //     uint256[] memory v4/* updated_reduction_proportion_ratio_data */ = E33.f40/* calculate_reduction_proportion_ratios */(v2/* exchange_nums */, v3/* data */[0/* actions */], block.number);
    //     /* update the proportions used for calculating the active mint limits in the exchange num data */

    //     v2/* exchange_nums */ = E32.f249/* update_mock_reduction_proportion_ratios */(v3/* mock_data */, v2/* exchange_nums */,v4/* updated_reduction_proportion_ratio_data */);

    //     v1/* mint_limits */ = E32.f250/* calculate_mock_tokens_to_receive */(v3/* mock_data */, v2/* exchange_nums */);
    // }

    /* get_spend_exchange_reduction_proportion */
    function f258() public view returns(uint256){
        return gv4/* num_data */.num[5/* spend_exchange_obj_id */][2][ 6 /* <6>active_block_limit_reduction_proportion */ ];
    }

    /* calculate_contract_minimum_end_or_spend */
    // function f286(
    //     uint256 p1/* default_minimum_end_amount */,
    //     uint256 p2/* default_minimum_spend_amount */,
    //     uint256 p3/* gas_anchor_price */,
    //     uint256 p4/* first_exchange_used */,
    //     uint256 p5/* transaction_gas_price */
    // ) external view returns(uint256){
    //     /* calculates the minimum end or spend that can be used for contract creation when defining entry fee amounts */
    //     uint256 rp = f258();
    //     /* get the get_spend_exchange_reduction_proportion */

    //     uint256 v1/* _type */ = 1;
    //     /* default to type 1 which is the spend exchange */

    //     if ( p4/* first_exchange_used */ == 3 /* end_exchange_obj_id */ ) {
    //         /* if the first exchange is the end exchange */
            
    //         v1/* _type */ = 2;
    //         /* set the value to type 2 which is the end exchange */
    //     }

    //     return E33.f8/* calculate_min_end_or_spend */([
    //         v1/* _type */,
    //         p1/* default_minimum_end_amount */,
    //         p5/* transaction_gas_price */,
    //         p3/* gas_anchor_price */,
    //         p2/* default_minimum_spend_amount */,
    //         rp,
    //         p4/* first_exchange_used */
    //     ]);
    // }


    //
    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
    /* call_update_total_minted_for_current_block */
    // function f1496( uint256[][5] memory p1/* data */, uint256[] memory p2/* tokens_to_receive */, uint256[][] calldata p3/* preset_data */ ) public {
    //     f1492(p3/* preset_data */);
    //     f149(p1/* data */, p2/* tokens_to_receive */);
    // }

    // uint256 num;
    // function f14911(uint256 new_num) public {
    //     num = new_num;
    // }

    /* set_preset_data */
    // function f1492(uint256[][] calldata p1/* preset_data */) public {
    //     for ( uint256 r = 0; r < p1/* preset_data */.length; r++ ) {
    //         if(p1/* preset_data */[r][0] == 1){
    //             gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ] = p1/* preset_data */[r][4];
    //             if(p1/* preset_data */[r].length > 5){
    //                 if(p1/* preset_data */[r][5] == 1){
    //                     gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ] = block.number;
    //                 }
    //                 if(p1/* preset_data */[r].length > 6){
    //                     if(p1/* preset_data */[r][6] == 5){
    //                         gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ] += p1/* preset_data */[r][7];
    //                     }else{
    //                         //3
    //                         gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ] -= p1/* preset_data */[r][7];
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }

    /* delete_preset_data */
    // function f1493(uint256[][] calldata p1/* preset_data */) public {
    //     for ( uint256 r = 0; r < p1/* preset_data */.length; r++ ) {
    //         if(p1/* preset_data */[r][0] == 1){
    //             gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ] = 0;
    //         }
    //     }
    // }

    /* read_preset_data */
    // function f1494(uint256[][] calldata p1/* preset_data */) public view returns(uint256[] memory v1/* return_data */) {
    //     v1/* return_data */ = new uint256[](p1.length);
    //     for ( uint256 r = 0; r < p1/* preset_data */.length; r++ ) {
    //         if(p1/* preset_data */[r][0] == 1){
    //             v1/* return_data */[r] = gv4/* num_data */.num[ p1/* preset_data */[r][1] ][ p1/* preset_data */[r][2] ][ p1/* preset_data */[r][3] ];
    //         }
    //     }
    // }

    /* read_block_number */
    // function f1495() public view returns(uint256){
    //     return block.number;
    // }

    // /* boot_exchange */
    // function f1497(
    //     uint256[][][] calldata p1/* boot_data */,
    //     uint256[][] calldata p2/* boot_id_data_type_data */,
    //     address p3/* h52_address */
    // ) public {
    //     gv3/* lock_addresses_mapping */[msg.sender] = true;
    //     gv5/* tokensData2 */ = H52(p3/* h52_address */);
    //     H3.f121/* boot */(p1/* boot_data */, p2/* boot_id_data_type_data */, gv4/* num_data */);
    // }

    /* t_call_execute_buy_or_sell_tokens */
    // uint256[3] q/* t_buy_sell_data */;
    // function f1498(
    //     uint256[][5] memory p1/* data */,
    //     uint256[4] memory p2/* metas */,
    //     bool p3/* authority_mint */,
    //     uint256[][2] memory p4/* buy_sell_limits */,
    //     uint256 p5/* loop */
    // ) public {
    //     for ( uint256 r = 0; r < p5/* loop */; r++ ) {
    //         if(r+1 == p5/* loop */){
    //             p1/* data */[3/* receivers */][0] = p1/* data */[3/* receivers */][0]+1;
    //         }
    //         q/* t_buy_sell_data */ = f180/* execute_buy_or_sell_tokens */(p1/* data */, p2/* metas */, p3/* authority_mint */, p4/* buy_sell_limits */);
    //     }
    // }

    /* get_buy_sell_data */
    // function f1499() public view returns(uint256[3] memory){
    //     return q/* t_buy_sell_data */;
    // }

    /* get_exchange_data */
    // function f14910() public view returns(uint256[3] memory v1/* data */){
    //     v1/* data */ = [
    //         gv4/* num_data */.num[5][2][2/* token_exchange_liquidity */], 
    //         gv4/* num_data */.num[5][2][4/* current_block_mint_total */], 
    //         gv4/* num_data */.num[5][2][6/* active_block_limit_reduction_proportion */]
    //     ];
    // }


    /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv3/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }


    // function func() external f155(msg.sender) {

    // }


    /* get_booted */
    // function f1572() external view returns (bool){
    //     return gv1/* booted */;
    // }

    // /* get_boot_data */
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
