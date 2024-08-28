import { LightningElement, api, wire } from 'lwc';
import getContacts from  '@salesforce/apex/ContactSearchController.getContacts';
import {getRecord} from 'lightning/uiRecordApi';

export default class DemoLWC4 extends LightningElement {

    @api recordId;
    @wire (getContacts , {accId : '$recordId'})
    contacts;

    @wire (getRecord, {recordId : '$recordId' , fields : 'Account.Name'})
    record;

    get name (){
        return this.record.data.fields.Account.value;
    }

}