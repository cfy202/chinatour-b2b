
package com.chinatour.util;
import java.util.UUID;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
/*
 * 生成UUID
 */
public class UUIDGenerator {
	public static Map<Integer,String> mUuid=new HashMap<Integer,String>();
	public final static  int nCount=5;
	public UUIDGenerator() {
		
	}
	public static String getUUID() {
		String sRet="";
		if(mUuid.isEmpty()){
			for (int i = 0; i < nCount; i++) {
				UUID uuid = UUID.randomUUID();
				String str = uuid.toString().toUpperCase();
				// String temp = str.substring(0,7)+str.substring(9,13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
				if(i==0){
					sRet=str; // temp
				}else{
					mUuid.put(new Integer(i), str);	//temp
				}
			}
		}
		else{
			for(Iterator iter=mUuid.keySet().iterator();iter.hasNext();){
				Integer v=(Integer)iter.next();
				sRet=(String)mUuid.get(v);
				mUuid.remove(v);
				break;
			}
		}
		return sRet;
	}
	
	public static void main(String[] args){
		/*System.out.println("52个UUID分别是：");		
		for(int i=0;i<52;i++){
			System.out.println(UUIDGenerator.getUUID());
		}*/
	}
}

