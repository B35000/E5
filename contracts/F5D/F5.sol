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

import "../E5D/E52.sol"; /* import "./E52.sol"; */
import "./F3.sol"; /* import "./SubscriptionHelperFunctions.sol"; */
import "./F33.sol"; /* import "./SubscriptionHelperFunctions3.sol"; */

import "../E5D/E3.sol"; /* import "../E5Data/E5HelperFunctions.sol"; */
import "../E5D/E32.sol"; /* import "../E5Data/E5HelperFunctions2.sol"; */
import "../E5D/E33.sol"; /* import "../E5Data/E5HelperFunctions3.sol"; */

import "../G5D/G5.sol"; /* import "./ContractsData/ContractsData.sol"; */
import "../G5D/G52.sol"; /* import "./ContractsData/ContractsData2.sol"; */

import "../H5D/H5.sol"; /* import "./TokensData/TokensData.sol"; */
import "../H5D/H52.sol"; /* import "./TokensData/TokensData2.sol"; */

contract F5 {
    event e1/* PaySubscription */( uint256 indexed p1/* subscription_id */, uint256 indexed p2/* sender_acc_id */, uint256 p3/* time_units_paid_for */, uint256 p4/* block_number */, uint256 p5/* timestamp */ );
    /* event emitted when a subscription is paid for */

    event e2/* CancelSubscription */( uint256 indexed p1/* subscription_id */, uint256 indexed p2/* sender_acc_id */, uint256 p3/* time_units_canceled */, uint256 p4/* block_number */, uint256 p5/* timestamp */ );
    /* event emitted when a subscription is cancelled */

    event e5/* ModifySubscription */( uint256 indexed p1/* subscription */, uint256 p2/* sender_account */, uint256 p3/* config_item_array */, uint256 p4/* config_item_pos */, uint256 p5/* new_config_item */, uint256 p6/* timestamp */, uint256 p7/* block_number */ );
    /* event emitted when a subscription is modified */

    event e4/* CollectSubscription */( uint256 indexed p1/* subscription_id */, uint256 indexed p2/* sender_acc_id */, uint256 p3/* total_time_units_collected */, uint256 p4/* block_number */, uint256 p5/* timestamp */ );
    /* event emitted when a subscription is collected */

    bool private gv1/* booted */ = false;
    /* indicates whether the contract has been booted */

    address private immutable gv2/* boot_address */;
    /* indicates the address that can boot the contract */

    mapping(address => bool) private gv3/* lock_addresses_mapping */;
    /* contains the addresses that can interact and send transactions to the contract */

    F3.NumData private gv4/* num_data */;
    /* data for this contract, whose structure is defined in the F3 library */

    E52 private gv5/* e52 */;
    /* global variable that points to the E52 contract */

    G5 private gv6/* contractsData */;
    /* global variable that points to the G5 contract */

    G52 private gv7/* contractsData2 */;
    /* global variable that points to the G52 contract */

    H5 private gv8/* tokensData */;
    /* global variable that points to the H5 contract */

    H52 private gv9/* tokensData2 */;
    /* global variable that points to the H52 contract */

    /* auth */
    modifier f152(address v1/* caller */) {
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
    function f159(
        address[7] calldata p1/* boot_addresses */,
        uint256[][][] calldata p2/* boot_data */,
        uint256[][] calldata p3/* boot_id_data_type_data */,
        string[][] calldata p4/* boot_object_metadata */,
        uint256[] calldata p5/* new_main_contract_config */
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
        gv5/* e52 */ = E52(p1/* boot_addresses */[ 1 /* E52Address */ ]);
        /* set the E52 contract using its address specified */

        gv6/* contractsData */ = G5(p1/* boot_addresses */[ 3 /* contractsDataAddress */ ]);
        /* set the G5 contract using its address specified */

        gv7/* contractsData2 */ = G52(p1/* boot_addresses */[ 4 /* contractsData2Address */ ]);
        /* set the G52 contract using its address specified */

        gv8/* tokensData */ = H5(p1/* boot_addresses */[ 5 /* tokensDataAddress */ ]);
        /* set the H5 contract using its address specified */

        gv9/* tokensData2 */ = H52(p1/* boot_addresses */[ 6 /* tokensData2Address */ ]);
        /* set the H52 contract using its address specified */

        gv6/* contractsData */.f160/* boot */(p1/* boot_addresses */, p2/* boot_data */, p3/* boot_id_data_type_data */);
        /* calls the boot function in the G5 contract */

        gv7/* contractsData2 */.f161/* boot */(p1/* boot_addresses */);
        /* calls the boot function in the G52 contract */

        gv8/* tokensData */.f162/* boot */(p1/* boot_addresses */, p2/* boot_data */, p3/* boot_id_data_type_data */);
        /* calls the boot function in the H5 contract */

        gv9/* tokensData2 */.f163/* boot */(p1/* boot_addresses */);
        /* calls the boot function in the H52 contract */

        gv5/* e52 */.f158/* boot */(p1/* boot_addresses */, p3/* boot_id_data_type_data */, p4/* boot_object_metadata */,p5/* new_main_contract_config */);
        /* calls the boot function in the E52 contract */
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* make_subscription_object */
    function f172(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f152(msg.sender) {
        /* transactions associated with creating subscription objects are sent here */

        uint256 v3/* obj_id */ = p1/* tx_data */.sv3/* temp_transaction_data */[p1/* tx_data */.t];
        /* record the new subscription id in a variable */
            
        f173/* record_new_objects_data */(v3/* obj_id */, p1/* tx_data */.sv4/* vals */, p1/* tx_data */.sv1/* user_acc_id */, p1/* tx_data */.sv3/* temp_transaction_data*/);
        /* calls the record new subscription data function */

        F3.f75/* start_run_checker */(v3/* obj_id */, gv4/* num_data */);
        /* calls the subscription data checker in the F3 helper library */

    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* run_f5_work */
    function f197(E3.TD/* TransactionData */ calldata p1/* tx_data */) external f152(msg.sender) {
        /* transactions associated with subscription actions start here */

        uint256 v1/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* record the transaction action */

        uint256 v2/* general_action */ = p1/* tx_data */.sv4/* vals */[0][0/* general_action */];
        /* record the general action */
        
        if(v2/* general_action */ == 20000 /* mod work */) {
            /* if the geeneral action is a mod action */

            if(v1/* action */ == 11 /* <11>modify_subscription */){
                /* if the action is a modify subscription action */

                uint256[][5] memory v3/* target_id_data */ = E3.f21/* get_primary_secondary_target_data */(p1/* tx_data */);
                /* get the modify data in a two dimentional array required */

                f196/* modify_subscription */( v3/* target_id_data */ , p1/* tx_data */.sv1/* user_acc_id */ );
                /* call the modify subscription action with the modify data passed */
            }
        }
        else if(v2/* general_action */ == 30000 /* token_transaction_work */){
            /* if the general action is a token transaction action */

            uint256[][5] memory v4/* target_id_data */ = E3.f260/* get_pay_or_cancel_subscription_data */(p1/* tx_data */);
            /* get the token transaction action data */

            if(v1/* action */ == 2 || /* <2>pay_subscription */ v1/* action */ == 12 /* <12>cancel_subscription */){
                /* if the action is a pay subscription action or cancel subscription action */

                uint256 v5/* sub_action */ = v1/* action */ == 2 ? 0 /* pay_subscription */ : 1; /* cancel_subscription */
                /* get the specific action from the transaction action specified */

                f213/* execute_pay_or_cancel_subscription */( v4/* target_id_data */ [ 0 /* target_subs */ ], p1/* tx_data */.sv4/* vals */[ 3 /* amounts */ ], p1/* tx_data */.sv1/* user_acc_id */, v5/* sub_action */, v4/* target_id_data */[1/* e */]);
                /* call the pay or cancel subscription function with the required arguments */
            }
            else if(v1/* action */ == 13 /* <13>collect_subscriptions */){
                /* if the action is a collect subscription action */

                uint256[][] memory v6/* payer_voter_accounts */ = E32.f30/* get_nested_account_data */( p1/* tx_data */.sv4/* vals */, v4/* target_id_data */ [ 0 /* target_subs */ ], 3);
                /* initialize a variable containing the accounts targeted for the collect subscription action */

                f215/* collect_subscriptions */(v4/* target_id_data */[ 0 /* target_subs */ ], v6/* payer_voter_accounts */, p1/* tx_data */.sv1/* user_acc_id */, v4/* target_id_data */[1/* e */]);
                /* call the collect subscription function with the specified arguments */
            }
        }
    }

    /* record_new_objects_data */
    function f173(
        uint256 p1/* new_obj_id */,
        uint256[][] memory p2/* t_vals */,
        uint256 p3/* user_acc_id */,
        uint256[] memory p4/* temp_transaction_data */
    ) private {
        /* records the new subscriptions data into storage */

        uint256[][] memory v1/* new_obj_id_num_data */ = E32.f31/* get_new_objects_data */(p2/* t_vals */, p3/* user_acc_id */, p4/* temp_transaction_data */, 10);
        /* calls the get new objects data function which calculates and sets the new subscriptions data in a two dimentional array object */

        F3.f103/* record_new_objects_data */(p1/* new_obj_id */, v1/* new_obj_id_num_data */, gv4/* num_data */);
        /* records the new subscriptions data into storage */
    }
    


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* execute_pay_or_cancel_subscription */
    function f213(
        uint256[] memory p1/* targets */,
        uint256[] memory p2/* amounts */,
        uint256 p3/* sender_account */,
        uint256 p4/* action */,
        uint256[] memory p5/* sender_accounts */
    ) private  {
        /* function used for paying or cancelling multiple subscription targets specified */
        /* action: 0 = pay_subscription , 1 = cancel_subscription */

        if(p4/* action */ == 0/* pay_subscription */){
            /* if the sub-action is a pay subscription action */

            gv5/* e52 */.f257/* ensure_interactibles_for_multiple_accounts */( p1/* targets */, p5/* sender_accounts */, p3/* sender_account */ );
            /* ensure the sender or senders can interact with the subscription target */
        }

        uint256[][5] memory v1/* data */ = F3.f107/* execute_pay_or_cancel_subscription */(p1/* targets */, p2/* amounts */, p3/* sender_account */, p4/* action */, gv4/* num_data */, p5/* sender_accounts */);
        /* calls the pay or cancel subscription function in the F3 helper library, storing the return value in memory */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target subscription */

            uint256 v2/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v2/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v2/* sender */ = p5/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }

            if ( p4/* action */ == 0 /* pay_subscription */ ) {
                /* if the sub-action is a pay subscription action */

                emit e1/* PaySubscription */( p1/* targets */[t], v2/* sender */, p2/* amounts */[t], block.number, block.timestamp );
                /* emit a pay subscription event */

            } else {
                /* if the action is a cancel subscription action */

                emit e2/* CancelSubscription */( p1/* targets */[t], v2/* sender */, p2/* amounts */[t], block.number, block.timestamp );
                /* emit a cancel subscription action */
            }
        }
        gv9/* tokensData2 */.f184/* execute_multi_transfer */( v1/* data */, 0, 0, false/* single_receiver_instead */, false/* single_sender_instead */,  1 );
    }

    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* collect_subscriptions */
    function f215(
        uint256[] memory p1/* targets */,
        uint256[][] memory p2/* payer_accounts */,
        uint256 p3/* sender_account */,
        uint256[] memory p4/* sender_accounts */
    ) private {
        /* function used to collect subscription payments */

        (uint256[][5] memory v1/* data */, uint256[] memory v2/* target_collectible_block_amounts */) = F3.f106/* collect_subscriptions */(p1/* targets */, p2/* payer_accounts */, p3/* sender_account */, gv4/* num_data */, p4/* sender_accounts */);
        /* call the collect subscription function in the F3 helper library */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target subscription specified */

            uint256 v3/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v3/* sender */ = p4/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }

            emit e4/* CollectSubscription */( p1/* targets */[t], v3/* sender */, v2/* target_collectible_block_amounts */[t], block.number, block.timestamp );
            /* emit a collect subscription event */
        }
        gv9/* tokensData2 */.f184/* execute_multi_transfer */( v1/* data */, 0, 0, false/* single_receiver_instead */, false/* single_sender_instead */,  1 );
    }




    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* modify_subscription */
    function f196(
        uint256[][5] memory p1/* data */,
        uint256 p2/* sender_account */
    ) public f152(msg.sender) {
        /* modifies a given set of subscription objects specified */

        F3.f104/* modify_subscription */(p1/* data */, p2/* sender_account */, gv4/* num_data */);
        /* calls the modify subscription function in the F3 helper library */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each subscription target specified */

            uint256 v1/* sender */ = p1/* data */[ 4 /* authority */ ].length != 0 ? p1/* data */[ 4 /* authority */ ][t] : p2/* sender_account */;
            /* initialize a sender variable as either the value in the array containing the authority data if exists or the sender of the transaction */

            emit e5/* ModifySubscription */( p1/* data */[ 0 /* targets */ ][t], v1/* sender */, p1/* data */[ 1 /* target_array_pos */ ][t], p1/* data */[ 2 /* target_array_items */ ][t], p1/* data */[ 3 /* new_items */ ][t], block.timestamp, block.number);
            /* emit a modify subscription action */
        }
    }


    //
    // ------------------------~~~AUTH~~~-------------------------------
    /* subscription_consensus_action_receiver */
    function f263(
        uint256[][][] memory v1/* target_nums */,
        uint256[21] calldata p2/* consensus_type_data */,
        uint256[][] memory p3/* payer_accounts */
    ) public f152(msg.sender) {

        uint256[][3][3] memory p1/* data */ = F33.f251/* get_collect_subscription_data */(p2/* consensus_type_data */, v1/* target_nums */);
        /* initialize a variable that contains the subscription action data */

        if( p2/* consensus_type_data */[ 8 /* collect_subscriptions */ ] != 0){
            /* if the consensus actions contains a collect subscriptions action */

            f215/* collect_subscriptions */(
                p1/* data */[0/* collect_subscription_action_data */][0/* target_subscriptions */], 
                p3/* payer_accounts */, 0/* sender_account */, 
                p1/* data */[0/* collect_subscription_action_data */][1/* sender_accounts */]
            );
        }

        if( p2/* consensus_type_data */[ 9 /* pay_subscriptions */ ] != 0){
            /* if the consensus actions contains a pay subscriptions action */

            f213/* execute_pay_or_cancel_subscription */(
                p1/* data */[1/* pay_subscription_action_data */][0/* target_subscriptions */], 
                p1/* data */[1/* pay_subscription_action_data */][2/* amounts */], 
                0/* sender_account */, 0/* pay_subscription_action */, 
                p1/* data */[1/* pay_subscription_action_data */][1/* sender_accounts */]
            );
        }

        if( p2/* consensus_type_data */[ 10 /* cancel_subscriptions */ ] != 0){
            /* if the consensus actions contains a cancel subscriptions action */

            f213/* execute_pay_or_cancel_subscription */(
                p1/* data */[2/* cancel_subscription_action_data */][0/* target_subscriptions */],
                p1/* data */[2/* cancel_subscription_action_data */][2/* amounts */], 
                0/* sender_account */, 1/* cancel_subscription_action */,
                p1/* data */[2/* cancel_subscription_action_data */][1/* sender_accounts */]
            );
        }
    }

    //
    //
    //
    //
    //
    //
    // ------------------------VIEW_FUNCTIONS-------------------------------
    /* read_ids */
    function f74(uint256[] memory p1/* _ids */) 
    public view returns (uint256[][][] memory) {
        /* reads the data for multiple subscription ids required */
        return F3.f74/* read_ids */(p1/* _ids */, gv4/* num_data */);
    }//-----TEST_OK-----

    /* read_id */
    function f73(uint256 id) 
    public view returns (uint256[][] memory) {
        /* reads the data for a subscription id specified */
        return F3.f73/* read_id */(id, gv4/* num_data */);
    }//-----TEST_OK-----

    /* scan_int_int_int */
    function f168(uint256[][] memory p1/* _ids */) 
    external view returns (uint256[] memory) {
        /* scans the int_int_int data storage object */
        return F3.f168/* scan_int_int_int */(p1, gv4/* num_data */);
    }//-----TEST_OK-----



    /* get_subscription_time_value */
    function f229(uint256[] calldata p1/* _ids */, uint256[][] calldata p2/* accounts */) 
    external view returns (uint256[][] memory v1/* data */) {
        return F3.f229/* get_subscription_time_value */(p1/* _ids */, gv4/* num_data */, p2/* accounts */);
    }//-----TEST_OK-----

    /* get_subscription_collectible_time_value */
    function f235(uint256[] calldata p1/* _ids */, uint256[][] calldata p2/* accounts */) 
    external view returns (uint256[][] memory v1/* data */) {
        return F3.f235/* get_subscription_collectible_time_value */(p1/* _ids */, gv4/* num_data */, p2/* accounts */);
    }//-----TEST_OK-----


    /* calculate_contract_minimum_end_or_spend */
    function f286(
        uint256 p1/* default_minimum_end_amount */,
        uint256 p2/* default_minimum_spend_amount */,
        uint256 p3/* gas_anchor_price */,
        uint256 p4/* first_exchange_used */,
        uint256 p5/* transaction_gas_price */,
        uint256 rp/* reduction_proportion */
    ) external pure returns(uint256){
        /* calculates the minimum end or spend that can be used for contract creation when defining entry fee amounts */

        uint256 v1/* _type */ = 1;
        /* default to type 1 which is the spend exchange */

        if ( p4/* first_exchange_used */ == 3 /* end_exchange_obj_id */ ) {
            /* if the first exchange is the end exchange */
            
            v1/* _type */ = 2;
            /* set the value to type 2 which is the end exchange */
        }

        return E33.f8/* calculate_min_end_or_spend */([
            v1/* _type */,
            p1/* default_minimum_end_amount */,
            p5/* transaction_gas_price */,
            p3/* gas_anchor_price */,
            p2/* default_minimum_spend_amount */,
            rp,
            p4/* first_exchange_used */
        ]);
    }


    //
    //
    //
    //
    //
    // ------------------------TEST_FUNCTIONS-------------------------------
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


     /* set_auth */
    // function f1496(address p1/* auth_address */, bool p2/* value */) public {
    //     gv3/* lock_addresses_mapping */[p1/* auth_address */] = p2/* value */;
    // }


    // function func() external f152(msg.sender) {

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


    // uint256[][3][3] p1e/* data */;
    // function f263t(
    //     uint256[][][] memory v1/* target_nums */,
    //     uint256[21] calldata p2/* consensus_type_data */,
    //     uint256[][] memory p3/* payer_accounts */
    // ) public {
    //     f263(v1/* target_nums */, p2/* consensus_type_data */, p3/* payer_accounts */);
    //     // p1e/* data */ = F33.f251/* get_collect_subscription_data */(v1/* target_nums */, p2/* consensus_type_data */, v1/* target_nums */);
    // }

    // function f2632t() public view returns(uint256[][3][3] memory){
    //     return p1e/* data */;
    // }

}
