import { LightningElement, api, wire } from 'lwc';
import initiateCall from '@salesforce/apex/CTIController.initiateCall';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import { CurrentPageReference } from 'lightning/navigation';
export default class ClickToDial extends LightningElement {

    wireRecordId; //this will hold the current record id fetched from pagereference

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.wireRecordId = currentPageReference.state.recordId;
            this.handleInitiateCall();
        }
    }

    handleInitiateCall(){
        console.log('Fetched recordId from the page:', this.wireRecordId);
        
        initiateCall({ customerRecordId: this.wireRecordId })
            .then(result => {
                console.log('Call initiated successfully', result);
                this.showToast('Success', 'Call initiated successfully', 'success');
                this.closeQuickAction();
            })
            .catch(error => {
                console.error('Error initiating call', error);
                this.showToast('Error', 'Error initiating call: ' + error.body.message, 'error');
                this.closeQuickAction();
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }

    closeQuickAction() {
        // Close the quick action popup using the CloseActionScreenEvent
        this.dispatchEvent(new CloseActionScreenEvent());
    }


    connectedCallback() {
        console.log('wireRecordId ', this.wireRecordId);
    }
}