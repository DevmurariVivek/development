import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import saveLead from '@salesforce/apex/CustomLeadController.saveLead';

export default class CustomLeadNew extends NavigationMixin(LightningElement) {
    @track lead = {
        FirstName: '',
        LastName: '',
        Company: ''
    };

    handleInputChange(event) {
        const field = event.target.label;
        this.lead[field] = event.target.value;
    }

    saveLead() {
        saveLead({ lead: this.lead })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Lead created successfully!',
                        variant: 'success',
                    })
                );
                // Navigate to the new lead record
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: result,
                        objectApiName: 'Lead',
                        actionName: 'view'
                    }
                });
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }

    cancel() {
        // Close the quick action modal
        this.dispatchEvent(new CustomEvent('close'));
    }
}