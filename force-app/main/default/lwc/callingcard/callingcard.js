import { LightningElement, api, wire} from 'lwc';
// import { getRecord } from 'lightning/uiRecordApi';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Phone_Field from '@salesforce/schema/Account.Phone';

const FIELDS = ['Account.Phone'];

export default class Callingcard extends LightningElement {

    @api recordId;

    maskedNumber;
    recordId;
    clickToDialParams = {};

    @wire(getRecord , {recordId : '$recordId' , fields : [Phone_Field] })
    record; // This record variable will have 2 types of values data and error

    // @wire (getRecord , {recordId : '$recordId' , fields : FIELDS})
    // account ({data, error}){
    //     if(data){
    //         this.phoneNumber = data.fields.Phone.value;
    //         this.maskPhoneNumber(this.phoneNumber);
    //         this.setClickToDialParams(this.phoneNumber);
    //         this.recordId = this.recordId;
    //     }else if(error){
    //         console.error('Error fetching account phone number', error);
    //     }
    // }

    // maskPhoneNumber(phone) {
    //     // Masking the phone number, showing only the last 4 digits
    //     this.maskedNumber = phone.replace(/\d(?=\d{4})/g, '#');
    // }

    // setClickToDialParams(phone) {
    //     // Setting the actual phone number in param1
    //     this.clickToDialParams = {
    //         unmaskedNumber: phone
    //     };
    // }
    connectedCallback (){
        console.log('data ===' ,this.record.data);
    }

    // get maskedNumber (){
    //     return this.record.data ? getFieldValue(this.record.data , Phone_Field) : '';
    // }
}