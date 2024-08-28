import { LightningElement } from 'lwc';
import templateOne from './templateOne.html';
import templateTwo from './templateTwo.html';

export default class RenderMultipleHTMLTemplatesLWC extends LightningElement {

    // This LWC will be used as an example to redner more than one html template in a single lwc component

    templateOne = true;
    render(){

        return this.templateOne ? templateOne : templateTwo;
    }

    switchTemplates(){

        this.templateOne = this.templateOne === true ? false : true;
    }
}