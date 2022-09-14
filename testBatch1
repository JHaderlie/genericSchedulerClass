global class testBatch1 implements Database.Batchable<sObject> {
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'SELECT Id,Name FROM Account LIMIT 1';		
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<Account> scope) {
		for(Account a : scope) {
			system.debug('testBatch1 '+a.Name);
		}
	}
	
	global void finish(Database.BatchableContext BC) {
	}
}
