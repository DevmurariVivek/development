// callLogAudioPlayer.js
import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

// Updated field and object API name with namespace
const FIELDS = ['ManagedCodeDev__Call_log__c.ManagedCodeDev__recordingLink__c'];

export default class CallLogAudioPlayer extends LightningElement {
    @api recordId; // Record ID of the current Call_log__c record
    recordingUrl;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (data) {
            // Fetch the URL from the recordingLink__c field
            this.recordingUrl = data.fields.ManagedCodeDev__recordingLink__c.value;
        } else if (error) {
            console.error('Error fetching record:', error);
        }
    }

    get isRecordingAvailable() {
        return this.recordingUrl != null;
    }
}
