


import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track selectedCaseId;

    handleCaseView(event) {
        this.selectedCaseId = event.detail.caseId;
    }
}
