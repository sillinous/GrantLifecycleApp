// Seed minimal data for E2E tests
// - Permission set assignment for Budget access
// - Budget settings (PermissionSet, CompanyCodes)
// - Project and Opportunity records
// - Opty_Grant_Fields__c mappings to render Convert page fields

Id currentUserId = UserInfo.getUserId();

// Ensure Permission Set exists and assign to current user
PermissionSet ps = [SELECT Id, Name FROM PermissionSet WHERE Name = 'Budget_Data_Access' LIMIT 1];
Boolean hasAssign = [SELECT COUNT() cnt FROM PermissionSetAssignment WHERE AssigneeId = :currentUserId AND PermissionSetId = :ps.Id] > 0;
if (!hasAssign) {
	insert new PermissionSetAssignment(AssigneeId = currentUserId, PermissionSetId = ps.Id);
}

// Budget Settings: PermissionSet and CompanyCodes
List<Budget_Settings__c> buds = new List<Budget_Settings__c>();
Budget_Settings__c bsPerm = Budget_Settings__c.getValues('PermissionSet');
if (bsPerm == null) {
	buds.add(new Budget_Settings__c(Name = 'PermissionSet', Id_Value__c = ps.Id));
}
Budget_Settings__c bsCodes = Budget_Settings__c.getValues('CompanyCodes');
if (bsCodes == null) {
	buds.add(new Budget_Settings__c(Name = 'CompanyCodes', String_Value__c = 'ORG1;ORG2'));
}
Budget_Settings__c bsMonth = Budget_Settings__c.getValues('CurrentDataMonth');
if (bsMonth == null) {
	buds.add(new Budget_Settings__c(Name = 'CurrentDataMonth', String_Value__c = 'December 31st 2099'));
}
if (!buds.isEmpty()) insert buds;

// Create Project
Project__c proj = new Project__c(Name = 'E2E Project', Use_YTD_Report__c = false);
insert proj;
System.debug('SEED:PROJECT=' + proj.Id);

// Create Opportunity
Account acc = new Account(Name = 'E2E Account');
insert acc;
Opportunity opp = new Opportunity(Name = 'E2E Opportunity', AccountId = acc.Id, CloseDate = Date.today().addDays(30), StageName = 'Prospecting');
insert opp;
System.debug('SEED:OPPORTUNITY=' + opp.Id);

// Opty -> Grant field mappings for Convert page
if ([SELECT COUNT() FROM Opty_Grant_Fields__c] == 0) {
	List<Opty_Grant_Fields__c> fields = new List<Opty_Grant_Fields__c>();
	fields.add(new Opty_Grant_Fields__c(Name = 'Id', Grant_Field__c = 'Source_Opportunity__c', Page_Order__c = 1, Section_on_Page__c = 1));
	fields.add(new Opty_Grant_Fields__c(Name = 'Name', Grant_Field__c = 'Name', Page_Order__c = 2, Section_on_Page__c = 1));
	fields.add(new Opty_Grant_Fields__c(Name = 'Grant_Period_Start__c', Grant_Field__c = 'Grant_Start_Date__c', Page_Order__c = 3, Section_on_Page__c = 1));
	fields.add(new Opty_Grant_Fields__c(Name = 'Grant_Period_End__c', Grant_Field__c = 'Grant_End_Date__c', Page_Order__c = 4, Section_on_Page__c = 1));
	insert fields;
}