import { api, wire, LightningElement } from 'lwc';

export default class ChildLWCdemo extends LightningElement {

    // @api 
    // recordName = 'Placeholder';
    // isShown = false;
    // handleChange(event){
    //     this.isShown = event.target.checked;
    // }

    //@api recordId;
    @api contacts = [];

    // @wire(getcontacts, { accId: '$recordId'})
    // wiredContacts({data, error}) {
    //     if(data){
    //         this.contacts = data;
    //     }else if(error){
    //         this.contacts = undefined
    //     }
    // }   

    connectedCallback(){
        console.log('the record in child---' , JSON.stringify(this.contacts));
    }

}