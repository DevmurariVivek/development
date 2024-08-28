import { api, wire, LightningElement } from 'lwc';
import getcontacts from '@salesforce/apex/contactControllerLwc.getcontacts';

export default class Parent extends LightningElement {

    @api recordId;
    contacts = [];

    @wire(getcontacts, { accId: '$recordId'})
    wiredContacts({data, error}) {
        if(data){
            this.contacts = data;
        }else if(error){
            this.contacts = undefined
        }
    }  

    connectedCallback(){
        console.log('the Id of account record parent ---' , this.recordId);
    }
}