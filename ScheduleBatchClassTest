@istest
public class ScheduleBatchClassTest {
    testMethod static void scheduleTest(){  
        test.startTest();
            ScheduleBatchClass sbc = new ScheduleBatchClass();
            sbc.batchClassName = 'testBatch1';
            sbc.batchSize = 50;
            sbc.allowSimultaneousBatches = true;
            System.schedule('scheduleTest','0 0 * * * ?',sbc);
        test.stopTest();        
    }
    testMethod static void executeScheduleTest(){  
        test.startTest();
            ScheduleBatchClass sbc1 = new ScheduleBatchClass();
            sbc1.batchClassName = 'testBatch1';
            sbc1.batchSize = 50;
            sbc1.allowSimultaneousBatches = true;
            sbc1.execute(null);
        test.stopTest();        
    }
    testMethod static void isRunningScheduleTest(){
		ScheduleBatchClass sbc2 = new ScheduleBatchClass();
        sbc2.batchClassName = 'testBatch1';
        sbc2.batchSize = 50;
        sbc2.allowSimultaneousBatches = true;
        sbc2.execute(null);
        
        test.startTest();
            ScheduleBatchClass sbc1 = new ScheduleBatchClass();
            sbc1.batchClassName = 'testBatch1';
            sbc1.batchSize = 50;
            sbc1.execute(null);
        test.stopTest();        
    }
}
