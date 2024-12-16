import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import makeCall from '@salesforce/apex/click2callLWCController.makeCall';

// Define fields to retrieve (you can add all potential phone fields here)
const PHONE_FIELDS = [
    'Account.Phone',
    'Account.MobilePhone',
    'Contact.Phone',
    'Contact.MobilePhone',
    'Lead.Phone'
];

export default class ClickToDial extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    phoneFields = []; // To store the detected phone fields
    
    // Fetch the record data using getRecord
    @wire(getRecord, { recordId: '$recordId', fields: PHONE_FIELDS })
    record;

    // Get phone fields dynamically
    get phoneFieldList() {
        const phoneFields = [];
        if (this.record.data) {
            Object.keys(this.record.data.fields).forEach(field => {
                if (this.record.data.fields[field].value && field.toLowerCase().includes('phone')) {
                    phoneFields.push({
                        label: field,
                        value: this.record.data.fields[field].value
                    });
                }
            });
        }
        return phoneFields;
    }

    handlePhoneClick(event) {
        const phoneNumber = event.target.dataset.phone;
        if (phoneNumber) {
            makeCall({ phoneNumber })
                .then(() => {
                    console.log('Call initiated successfully.');
                })
                .catch(error => {
                    console.error('Error initiating call:', error);
                });
        } else {
            console.error('Phone number is undefined or null');
        }
    }
}
