package com.dovile.organizer.util;


import java.util.Date;

public class CheckTime {
	
	
	public static boolean reservationTime(Date date_s1, Date date_f1, Date date_s2, Date date_f2) {



        long s1 = date_s1.getTime();
        long f1 = date_f1.getTime();
        long s2 = date_s2.getTime();
        long f2 = date_f2.getTime();

        
        
        

        if (s1 <= s2 && f1 <= s2 & s1 <= f2 && f1 <= f2 && s2 < f2 ) {
            return true;
        } else if (s1 >= s2 && f1 >= s2 & s1 >= f2 && f1 >= f2 && s2 < f2) {
            return true;
        } else {
            return false;

        }
    }

}
