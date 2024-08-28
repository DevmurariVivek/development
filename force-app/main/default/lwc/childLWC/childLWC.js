import { LightningElement, api } from 'lwc';

export default class ChildLWC extends LightningElement {
    @api message;
}