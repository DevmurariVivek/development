import { LightningElement, api, wire } from 'lwc';
import {getRecords} from 'lightning/uiRecordApi';
import Account_record_name from '@salesforce/schema/Account.Name';

export default class DemoLWC3 extends LightningElement {

    @api message ; // public property using @api annotation // here if we want to fetch record id of the current record id from ui where this lwc will be added we can store the id of record in this public propertu=y using @api recordId ;
    private_var ; // prictae property only accessible in this js 

    @api recordId;
    @wire (getRecords , {recordId : '$recordId' , fields : [Account_record_name]})
    record ; // this record property will have 2 kind of responses, record.data and record.error where data returns actual data and error returns error if any

    method1(){
        console.log(this.record.data);
    }
}