package com.dovile.organizer.util;

import java.util.Date;

public class TimeDuration {
	
	
	public static String durationTime(Date dNow1, Date dNow) {
		long d1Ms = dNow1.getTime();
        long d2Ms = dNow.getTime();
        long minute = Math.abs((d1Ms - d2Ms) / 60000);
        int Hours = (int) minute / 60;
        int Minutes = (int) minute % 60;
        
        String hour = Integer.toString(Hours);
        String min =Integer.toString(Minutes);
        
        if (hour.length() == 1) {
        	hour="0"+hour;
        }
        
        if (min.length() == 1) {
        	min="0"+min;
        }  
        
        return hour + ":" + min;
	}

}
