import { LightningElement, api, wire } from 'lwc';
import getCaseDetails from '@salesforce/apex/CaseDetailsApexController.getCaseDetails';

export default class CaseDetails extends LightningElement {
    @api caseId;
    caseDetails;
    error;

    @wire(getCaseDetails, { caseId: '$caseId' })
    wiredCase({ error, data }) {
        if (data) {
            this.caseDetails = data;
            this.error = undefined;
        } else if (error) {
            this.caseDetails = undefined;
            this.error = 'Error fetching case details: ' + error.body.message;
        }
    }

    get caseUrl() {
        return `/lightning/r/Case/${this.caseDetails.Id}/view`;
    }
}
