import { LightningElement,wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Name_Field from '@salesforce/schema/Account.Name';
import Phone_Field from '@salesforce/schema/Account.Phone';


export default class Property_in_lwc extends LightningElement {

    @api recordId;
    
    @wire(getRecord , {recordId : '$recordId' , fields : [Name_Field , Phone_Field] })
    record; // This record variable will have 2 types of values data and error

    // defined private properties whose scope is limited to current lwc file only 
    message = 'Message from LWC JS';
    recordId;


    connectedCallback (){
        console.log(this.record.data);
    }

    get name (){
        return this.record.data ? getFieldValue(this.record.data , Name_Field) : '';
    }

    get phone (){
        return this.record.data ? getFieldValue(this.record.data , Phone_Field) : '';
    }
    // wire is used to import data from salesforce -- we first have to import the module - function from different modules to be used in lwc componment
}