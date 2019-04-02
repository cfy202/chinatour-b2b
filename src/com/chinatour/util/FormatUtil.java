package com.chinatour.util;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
public class FormatUtil {
	public static final String getPattern(Double dVal){
		String ret="";
		if(dVal.doubleValue()>0){
			DecimalFormat nf=new DecimalFormat();
	        nf.setMaximumFractionDigits(8);
	        nf.setMinimumFractionDigits(2);
	        nf.setDecimalSeparatorAlwaysShown(true);
	        ret=nf.format(dVal); 
		}
		return ret;
	}
	  
	public static final String getDate(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyy年MM月dd日 ");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	
	public static final String getMinuteTime(Date dt){
        if(dt!=null){
        	SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm");  
            String ret=dateformat.format(dt);
            return ret;
		}else{
			return "";
		}
	}
	
	public static final String compareDate(Date from,Date to){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if(from != null && to != null && df.format(from).compareTo( df.format(to)) == 0){
		     return "1";
		}else{
			return "0";
		}
	}
	

	public static final String compareYearAndMonth(Date from,Date to){
		DateFormat df = new SimpleDateFormat("yyyy-MM");
		if(from != null && to != null && df.format(from).compareTo(df.format(to)) == 0){
		     return "1";
		}else{
			return "0";
		}
	}
	
	public static final String compareMonth(Date from,Date to){
		DateFormat df = new SimpleDateFormat("MM-dd");
		if(from != null && to != null && df.format(from).compareTo(df.format(to)) == 0){
		     return "1";
		}else{
			return "0";
		}
	}
	
	public static final String getMonth(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyyMM");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	
	public static final String getMonthChs(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyy年MM月");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	
	public static final String getStandardDate(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyyMMdd");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	public static final String getStandard(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("MM/dd/yyyy");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	public static final String getDateStrForOrder(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	public static final String getNextMonth(Date dt){
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM", Locale.US);
        Calendar calender = Calendar.getInstance();
        calender.setTime(dt);
        calender.add(Calendar.MONTH, 1);
        String s=simpleDateFormat.format(calender.getTime());
        return s;
	}
	
	public static final String getYear(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyy");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	public static final String getNextMonth(String month){
		String sYear=month.substring(0, 4);
		String sMonth=month.substring(4,6);
		String sRet="";
		Integer nYear=new Integer(sYear);
		Integer nMonth=new Integer(sMonth);
		switch(nMonth){
		case 1:
			sRet=sYear+"02";
			break;
		case 2:
			sRet=sYear+"03";
			break;
		case 3:
			sRet=sYear+"04";
			break;
		case 4:
			sRet=sYear+"05";
			break;
		case 5:
			sRet=sYear+"06";
			break;
		case 6:
			sRet=sYear+"07";
			break;
		case 7:
			sRet=sYear+"08";
			break;
		case 8:
			sRet=sYear+"09";
			break;
		case 9:
			sRet=sYear+"10";
			break;
		case 10:
			sRet=sYear+"11";
			break;
		case 11:
			sRet=sYear+"12";
			break;
		case 12:
			nYear+=1;
			sRet=nYear+"01";
			break;
		}
		return sRet;
	}
	
	public static final String getLastMonth(String month){
		String sYear=month.substring(0, 4);
		String sMonth=month.substring(4,6);
		String sRet="";
		Integer nYear=new Integer(sYear);
		Integer nMonth=new Integer(sMonth);
		switch(nMonth){
		case 1:
			nYear-=1;
			sRet=nYear+"12";
			break;
		case 2:
			sRet=sYear+"01";
			break;
		case 3:
			sRet=sYear+"02";
			break;
		case 4:
			sRet=sYear+"03";
			break;
		case 5:
			sRet=sYear+"04";
			break;
		case 6:
			sRet=sYear+"05";
			break;
		case 7:
			sRet=sYear+"06";
			break;
		case 8:
			sRet=sYear+"07";
			break;
		case 9:
			sRet=sYear+"08";
			break;
		case 10:
			sRet=sYear+"09";
			break;
		case 11:
			sRet=sYear+"10";
			break;
		case 12:
			sRet=nYear+"11";
			break;
		}
		return sRet;
	}
	
	public static String getgrandTime(String startTime,int day){
		long nd = 1000*24*60*60;//一天的毫秒数
		long diff;
		String str=null;
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		try{
			diff=sd.parse(startTime).getTime()-day*nd;		
			
		    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		    str=formatter.format(diff);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return str;
	}
	
	public static String[] getMonthArr(String year){
		String[] arrMonth=new String[12];
		arrMonth[0]=year+"01";
		arrMonth[1]=year+"02";
		arrMonth[2]=year+"03";
		arrMonth[3]=year+"04";
		
		arrMonth[4]=year+"05";
		arrMonth[5]=year+"06";
		arrMonth[6]=year+"07";
		arrMonth[7]=year+"08";
		
		arrMonth[8]=year+"09";
		arrMonth[9]=year+"10";
		arrMonth[10]=year+"11";
		arrMonth[11]=year+"12";
		return arrMonth;
	}

	
	/**
	 * 获取保留2位的财务浮点数
	 * @param dVal
	 * @return
	 */
	public static Double getStandardDouble(Double dVal){
		 BigDecimal bg = new BigDecimal(dVal);
	     double f1 = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	     return new Double(f1);
   }
   
   public static String GetSysDate(String format, String StrDate, int year,
			int month, int day) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sFmt = new SimpleDateFormat(format);
		cal.setTime(sFmt.parse((StrDate), new ParsePosition(0)));

		if (day != 0) {
			cal.add(cal.DATE, day);
		}
		if (month != 0) {
			cal.add(cal.MONTH, month);
		}
		if (year != 0) {
			cal.add(cal.YEAR, year);
		}
		cal.set(cal.DATE, 1);
		return sFmt.format(cal.getTime());
	}	
	/**
	 * 获取指定年数或者月数的第1天日期
	 * @param format
	 * @param StrDate
	 * @param year
	 * @param month
	 * @param day
	 * @param specificDay 为-1时，表示不应用指定日期，否则为指定日期
	 * @return
	 */
	public static String GetFirstDayOfNextMonth(String format, String StrDate, int year,
			int month) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sFmt = new SimpleDateFormat(format);
		cal.setTime(sFmt.parse((StrDate), new ParsePosition(0)));

//		if (day != 0) {
//			cal.add(cal.DATE, day);
//		}
		if (month != 0) {
			cal.add(cal.MONTH, month);
		}
		if (year != 0) {
			cal.add(cal.YEAR, year);
		}
		cal.set(cal.DATE, 1);
		return sFmt.format(cal.getTime());
	}	
	
	public static String GetLastDayOfSpecificMonthOfYear(String format, String StrDate, int year,int month) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sFmt = new SimpleDateFormat(format);
		cal.setTime(sFmt.parse((StrDate), new ParsePosition(0)));
		if (year != 0) {
			cal.add(cal.YEAR, year);
		}
		if (month != 0) {
			cal.add(cal.MONTH, month);
		}
		cal.set(cal.DATE, 1);									//先将时间设置为第一天，
		cal.set(Calendar.DATE,cal.get(Calendar.DATE)-1); 		//多加1个月，然后天数-1即得上月最后一天
		return sFmt.format(cal.getTime());
	}	
	
	public static final String getStandardTime(Date dt){
		if(dt!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyyMMddHHmmss");  
	        String ret=dateformat.format(dt);
	        return ret;
		}else{
			return "";
		}
	}
	
	public static final Date getDate(String sdate){
		if(sdate!=null){
			SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");  
	        Date ret = null;
			try {
				ret = dateformat.parse(sdate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return ret;
		}else{
			return null;
		}
	}
	
	public static final String stripHtml(String content) { 
		// <p>段落替换为换行 
		content = content.replaceAll("<p .*?>", "\r\n"); 
		// <br><br/>替换为换行 
		content = content.replaceAll("<br\\s*/?>", "\r\n"); 
		// 去掉其它的<>之间的东西 
		content = content.replaceAll("\\<.*?>", ""); 
		// 还原HTML 
		// content = HTMLDecoder.decode(content); 
		return content; 
	}
}
