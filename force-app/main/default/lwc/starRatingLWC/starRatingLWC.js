import { LightningElement,api } from 'lwc';
import { FlowAttributeChangeEvent }from 'lightning/flowSupport';

export default class starRatingLWC extends LightningElement {
  @api ratingValue;
  
  rating(event){
    const attributeChangeEvent = new FlowAttributeChangeEvent('ratingValue', event.target.value);
    this.dispatchEvent(attributeChangeEvent);
  }
  
}