package com.peakcentre.web.entity;

public class workoutSummary {
	
	int week;
	int[][] summary;
	
	public workoutSummary(){
		summary = new int[week][7];
	}

}
