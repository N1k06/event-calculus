package it.univpm.airtlab.jrec.test;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestGen {

	public static long BASE_MILLIS = 1484763612759L; //Wed Jan 18 2017 19:20:12
	public static long MINUTE_MILLIS = 1000 * 60;
	public static long HOUR_MILLIS = MINUTE_MILLIS * 60;
	public static long DAY_MILLIS = HOUR_MILLIS * 24;
	public static long WEEK_MILLIS = DAY_MILLIS * 7;
	
	private static String vecToArgs(int vec[]){
		String str="";
		
		if (vec.length > 0) {
			str = Integer.toString(vec[0]);
			
			for (int i=1; i<(vec.length);i++){
				str = str + "," + Integer.toString(vec[i]);
			}
			str = "(" + str + ")";			
		}
		return str;
	}
	
	private static String convertMillisToDate(long millis) {
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    	Date date=new Date(millis);

		return df.format(date);
	}
	
	public static void createTestSingleAlert(long baseMillis,long step, int n, 
			String evName, int aboveThr[], int belowThr[], String filepath){
		String argsNoAlert, argsAlert, line;
		
		long randBase,randRange,randStep;
		long accStep = baseMillis;
				
		argsNoAlert = vecToArgs(belowThr);
		argsAlert = vecToArgs(aboveThr);
		
		randBase = step - (long) step/20;
		randRange = (long) step/10;
		accStep = baseMillis;
		
		try{
		    PrintWriter writer = new PrintWriter(filepath, "UTF-8");
		
	        for(int i=1; i<=n; i++){
	        	randStep = randBase + (long)(Math.random() * randRange);
	        	if (i==n){
	        		line = convertMillisToDate(accStep) + ";" + evName + argsAlert;
	        	} else {
	        		line = convertMillisToDate(accStep) + ";" + evName + argsNoAlert;
	        	}
	        	accStep = accStep + randStep;
			    writer.println(line);	        	
	        }
	        
		    writer.close();
		    
		} catch (Exception e) {
			// do something
			}	
	}
	
	public static void createTestMultAlert(long baseMillis,long step, int n, 
			String evName, int aboveThr[], int belowThr[], int alertRatio ,String filepath){
		String argsNoAlert, argsAlert, line;
		
		long randBase,randRange,randStep;
		long accStep = baseMillis;
				
		argsNoAlert = vecToArgs(belowThr);
		argsAlert = vecToArgs(aboveThr);
		
		randBase = step - (long) step/20;
		randRange = (long) step/10;
		accStep = baseMillis;
		
		try{
		    PrintWriter writer = new PrintWriter(filepath, "UTF-8");
		    
	        for(int i=1; i<=n; i++){
	        	
	        	randStep = randBase + (long)(Math.random() * randRange);
	        	if ((int)(Math.random() * alertRatio) == 0 ){
	        		line = convertMillisToDate(accStep) + ";" + evName + argsAlert;
	        	} else {
	        		line = convertMillisToDate(accStep) + ";" + evName + argsNoAlert;

	        	}
	        	accStep = accStep + randStep;
			    writer.println(line);
	        }
	        
		    writer.close();
		    
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public static void createCmplxTestSingleAlert(long baseMillis,long step, int n, 
			String evName, int aboveThr[], int belowThr[], String filepath){
		String argsNoAlert, argsAlert, line;
		
		long randBase,randRange,randStep;
		long accStep = baseMillis;
				
		argsNoAlert = vecToArgs(belowThr);
		argsAlert = vecToArgs(aboveThr);
		
		randBase = step - (long) step/20;
		randRange = (long) step/10;
		accStep = baseMillis;
		
		try{
		    PrintWriter writer = new PrintWriter(filepath, "UTF-8");
		
	        for(int i=1; i<=n; i++){
	        	randStep = randBase + (long)(Math.random() * randRange);
	        	if (i>=(n-1)){
	        		line = convertMillisToDate(accStep) + ";" + evName + argsAlert;
	        	} else {
	        		line = convertMillisToDate(accStep) + ";" + evName + argsNoAlert;
	        	}
	        	accStep = accStep + randStep;
			    writer.println(line);	        	
	        }
	        
		    writer.close();
		    
		} catch (Exception e) {
			// do something
			}	
	}
}
