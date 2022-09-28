global with sharing class ScheduleBatchClass implements Schedulable  { 
    global string batchClassName {get;set;}
    global integer batchSize {get;set;}
    global boolean allowSimultaneousBatches {get;set;}
    
    global void execute(SchedulableContext sc) {
        Database.Batchable<sObject> batchClassNameObj = (Database.Batchable<sObject>)createInstance(batchClassName);
        
        if(batchSize < 1 || batchSize == null) {batchSize = 20;}
        if(batchSize > 2000) {batchSize = 2000;}
        
        if(!isBatchApexJobRunning(batchClassName) || allowSimultaneousBatches == true) {
            Database.executebatch(batchClassNameObj,batchSize);
        }
    }
    
    private static Boolean isBatchApexJobRunning(String className) { 
        Boolean isBatchApexJobRunning = false;
        List<AsyncApexJob> runningJobs = [Select Id, ApexClassId From AsyncApexJob Where Status='Processing' OR Status='Holding' OR Status='Queued'];
        if(runningJobs!=null && runningJobs.size()>0) {
            isBatchApexJobRunning = processBatchApexJobRunning(className, runningJobs);
        }
        return isBatchApexJobRunning; 
    }
    
    private static Boolean processBatchApexJobRunning(String className, List<AsyncApexJob> runningJobs) {
        Boolean isBatchApexJobRunning = false;
        Set<String> apexClassIds = new Set<String>();
        for(AsyncApexJob aj : runningJobs) {
            apexClassIds.add(aj.ApexClassId);
        }
        List<ApexClass> runningClasses = [Select Id, Name From ApexClass where Id IN :apexClassIds AND Name=:className];    
        if(runningClasses!=null && runningClasses.size()>0) isBatchApexJobRunning = true;
        return isBatchApexJobRunning; 
    }
    private Object createInstance(String clz) {
        Type typ;
        if (clz.contains('.')){
            string[] splitclz = clz.split('\\.');
            typ = Type.forName(splitclz[0],splitclz[1]);
        } else {
            typ = Type.forName(clz);
        }
        Object instance = null;
        if (typ != null) {
            instance = typ.newInstance();
        }
        return instance;
    }
}
/* EXAMPLE execute anonymous to schedule job
        integer i=0;
        while(i<60){
            ScheduleBatchClass sbc1 = new ScheduleBatchClass();
            sbc1.batchClassName = 'testBatch1';
            sbc1.batchSize = 50;
            sbc1.allowSimultaneousBatches = true;
            System.schedule('testBatch1 on min '+i,'0 '+i+' * * * ?',sbc1);
        
            ScheduleBatchClass sbc2 = new ScheduleBatchClass();
            sbc2.batchClassName = 'testBatch2';
            sbc2.batchSize = 50;
            sbc2.allowSimultaneousBatches = true;
            System.schedule('testBatch2 on min '+i,'0 '+i+' * * * ?',sbc2);
        
            i = i+5;
        }
*/
/* DELETE ALL SCHEDULED JOBS-
        LIST<CronTrigger> query = [select Id from CronTrigger];
        For (CronTrigger i : query){ 
            System.abortJob(i.Id); 
        }
*/
