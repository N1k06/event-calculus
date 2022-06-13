package it.univpm.airtlab.jrec.test;

public class GenDataset {

	public static void main(String args[]){

		int nEv = Integer.parseInt(args[0]); //number of events to be generated on the dataset
		int type = Integer.parseInt(args[1]); //0:dense single, 1:dense multi, 2:sparse single, 3: sparse multi
		String outPath = args[2];

		switch (type){
		
		//All the events happen in the same timewindow (dense)
		case 1:
			//seqMultAl_dense
			TestGen.createTestMultAlert(TestGen.BASE_MILLIS, 5000, nEv,
				"glucose", new int[]{203},new int[] {68}, 2, outPath);
		break;
		
		case 2:
			//seqSingleAl_dense
			TestGen.createTestSingleAlert(TestGen.BASE_MILLIS, 5000, nEv,
				"glucose", new int[]{203},new int[] {68}, outPath);
		break;	
		
		//The event are sparse in relation to the duration of the timewindow (sparse)
		case 3:
			//seqMultAl_sparse
			TestGen.createTestMultAlert(TestGen.BASE_MILLIS, 5000, nEv,
				"glucose", new int[]{203},new int[] {68}, 2, outPath);
		break;				
			
		case 4:
			//seqSingleAl_sparse
			TestGen.createTestSingleAlert(TestGen.BASE_MILLIS, 5000, nEv,
				"glucose", new int[]{203},new int[] {68}, outPath);
		break;

		//All the events happen in the same timewindow
		case 5:
			//cmplxMultAl_dense
			TestGen.createTestMultAlert(TestGen.BASE_MILLIS, TestGen.MINUTE_MILLIS, nEv,
				"blood_pressure", new int[]{140,90},new int[] {120,70}, 2, outPath);
		break;
			
		case 6:	
			//cmplxSingleAl_dense
			TestGen.createCmplxTestSingleAlert(TestGen.BASE_MILLIS, TestGen.MINUTE_MILLIS, nEv,
				"blood_pressure", new int[]{140,90},new int[] {120,70}, outPath);
		break;
		
		//The event are sparse in relation to the duration of the timewindow
		case 7:
			//cmplxMultAl_sparse
			TestGen.createTestMultAlert(TestGen.BASE_MILLIS, TestGen.DAY_MILLIS, nEv,
					"blood_pressure", new int[]{140,90},new int[] {120,70}, 2, outPath);
		break;
		
		case 8:
			//cmplxSingleAl_sparse
			TestGen.createCmplxTestSingleAlert(TestGen.BASE_MILLIS, TestGen.DAY_MILLIS, nEv,
				"blood_pressure", new int[]{140,90},new int[] {120,70}, outPath);
		break;
		
		default:
			System.out.println("TyOption not recognized.");
		
		}
		System.out.println("Done!");
	}
}