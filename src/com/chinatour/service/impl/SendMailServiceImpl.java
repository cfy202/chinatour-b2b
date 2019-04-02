package com.chinatour.service.impl;

import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;

import com.chinatour.entity.Customer;
import com.chinatour.entity.InvoiceMail;
import com.chinatour.entity.Order;
import com.chinatour.service.SendMailService;

@Service
public class SendMailServiceImpl implements SendMailService {
  //private static final Log logger = LogFactory.getLog(SendHTMLMail.class);    
	   
    private static final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";    
   
    private static final String USERNAME = "noreply@chinatour.com";//设定邮箱的用户名    
   
    private static final String PASSWORD = "Chevron378c1";//设定邮箱的密码   
   
    //private static final String TO_EMAIL = "763656270@qq.com";//设定收件人的信箱    
   
    //private static final String SUBJECT = "A HTML Test mail!";//设定邮件标题    
   
    private static final String FROM = "noreply@chinatour.com";//设定发件件的人    
   
    private static final String SMTP = "smtp.exmail.qq.com";    
   
   
    public  void sender(InvoiceMail invoiceMail) throws Exception {    
    	Properties props = System.getProperties();    
        props.setProperty("mail.smtp.host", SMTP);    
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);    
        props.setProperty("mail.smtp.socketFactory.fallback", "false");    
        props.setProperty("mail.smtp.port", "465");    
        props.setProperty("mail.smtp.socketFactory.port", "465");    
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        Session session = Session.getDefaultInstance(props,    
                new Authenticator() {    
                    protected PasswordAuthentication getPasswordAuthentication() {    
                        return new PasswordAuthentication(USERNAME, PASSWORD);    
                    }    
                }); 
        //设置在控制台打印发送信息
        session.setDebug(true);
        Message msg = new MimeMessage(session);
        MimeMultipart msgMimeMultipart = new MimeMultipart("mixed"); //mixed为混合类型
        //这只邮件类型为混合型以添加附件
        msg.setContent(msgMimeMultipart);
        //设置发件人
        msg.setFrom(new InternetAddress(FROM));
        
        //设置收件人为多位时，可用逗号隔开
        
        msg.setRecipients(RecipientType.TO,InternetAddress.parse(invoiceMail.getAddressTo()));
        
        //设置邮件回复
        InternetAddress[] replyAdd = {new InternetAddress(MimeUtility.encodeText(FROM)+"<"+FROM+">")}; 
        msg.setReplyTo(replyAdd);
        
       //设置邮件主题 
        String fileName ="";
        String subject = "";
        sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
        String orderNo = invoiceMail.getOrderNo();
        String tourCode = "";
        if(invoiceMail.getTourCode()!=null&&invoiceMail.getTourCode().length()!=0){
        	tourCode = "("+invoiceMail.getTourCode()+")";
        }
        String lineName = invoiceMail.getLineName();
        
        if(invoiceMail.getIOrV()==1){//如果数值为1：则产生invoice
        	if(tourCode!=null&&tourCode!=""){
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        	}else{
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        	}
        	
        }else if(invoiceMail.getIOrV()==2){//如果数值为2：则产生voucher
        	subject = MimeUtility.encodeText("(文景假期)voucher-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        	fileName = MimeUtility.encodeText("(文景假期)voucher-"+orderNo+"-"+tourCode+lineName+"&"+invoiceMail.getItInfo());
        }
        
        msg.setSubject(subject);
        
        //准备附件
       BodyPart fileurl = new MimeBodyPart();
        //将附件设置到msgMimeMultipart中
        msgMimeMultipart.addBodyPart(fileurl);
        
        //给附件设置内容
        
        DataSource fileurlContent = new FileDataSource(invoiceMail.getDestPath());
       //向附件内添加数据
        fileurl.setDataHandler(new DataHandler(fileurlContent));
        
        //为保证文件名不会乱码
        
        fileurl.setFileName(fileName+".pdf");
        
       // MimeMultipart bodyMultipart = new MimeMultipart("ralated");
        Transport.send(msg);
        
    }
    public  void senderForOpConfirm(InvoiceMail invoiceMail) throws Exception {    
    	Properties props = System.getProperties();    
        props.setProperty("mail.smtp.host", SMTP);    
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);    
        props.setProperty("mail.smtp.socketFactory.fallback", "false");    
        props.setProperty("mail.smtp.port", "465");    
        props.setProperty("mail.smtp.socketFactory.port", "465");    
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        Session session = Session.getDefaultInstance(props,    
                new Authenticator() {    
                    protected PasswordAuthentication getPasswordAuthentication() {    
                        return new PasswordAuthentication(USERNAME, PASSWORD);    
                    }    
                }); 
        //设置在控制台打印发送信息
        session.setDebug(true);
        Message msg = new MimeMessage(session);
        MimeMultipart msgMimeMultipart = new MimeMultipart("mixed"); //mixed为混合类型
        //这只邮件类型为混合型以添加附件
        msg.setContent(msgMimeMultipart);
        //设置发件人
        msg.setFrom(new InternetAddress(FROM));
        
        //设置收件人为多位时，可用逗号隔开
        
        msg.setRecipients(RecipientType.TO,InternetAddress.parse(invoiceMail.getAddressTo()));
        
        //设置邮件回复
        InternetAddress[] replyAdd = {new InternetAddress(MimeUtility.encodeText(FROM)+"<"+FROM+">")}; 
        msg.setReplyTo(replyAdd);
        
       //设置邮件主题 
        String fileName ="";
        String subject = "";
        sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
        String orderNo = invoiceMail.getOrderNo();
        String tourCode = "";
        if(invoiceMail.getTourCode()!=null&&invoiceMail.getTourCode().length()!=0){
        	tourCode = "("+invoiceMail.getTourCode()+")";
        }
        String lineName = invoiceMail.getLineName();
        if(invoiceMail.getIOrV()==1){//如果数值为1：则产生invoice
        	if(tourCode!=null&&tourCode!=""){
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName);
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName);
        	}else{
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName);
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo+"-"+tourCode+lineName);
        	}
        	
        }else if(invoiceMail.getIOrV()==2){//如果数值为2：则产生voucher
        	subject = MimeUtility.encodeText("(文景假期) Final-voucher-"+orderNo+"-"+tourCode);
        	fileName = MimeUtility.encodeText("(文景假期)Final-voucher-"+orderNo+"-"+tourCode);
        }
        
        msg.setSubject(subject);
        
        //准备附件
       BodyPart fileurl = new MimeBodyPart();
        //将附件设置到msgMimeMultipart中
        msgMimeMultipart.addBodyPart(fileurl);
        
        //给附件设置内容
        
        DataSource fileurlContent = new FileDataSource(invoiceMail.getDestPath());
       //向附件内添加数据
        fileurl.setDataHandler(new DataHandler(fileurlContent));
        
        //为保证文件名不会乱码
        
        fileurl.setFileName(fileName+".pdf");
        
       // MimeMultipart bodyMultipart = new MimeMultipart("ralated");
        Transport.send(msg);
        
    }
    public  void senderForAir(InvoiceMail invoiceMail) throws Exception {    
    	Properties props = System.getProperties();    
        props.setProperty("mail.smtp.host", SMTP);    
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);    
        props.setProperty("mail.smtp.socketFactory.fallback", "false");    
        props.setProperty("mail.smtp.port", "465");    
        props.setProperty("mail.smtp.socketFactory.port", "465");    
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        Session session = Session.getDefaultInstance(props,    
                new Authenticator() {    
                    protected PasswordAuthentication getPasswordAuthentication() {    
                        return new PasswordAuthentication(USERNAME, PASSWORD);    
                    }    
                }); 
        //设置在控制台打印发送信息
        session.setDebug(true);
        Message msg = new MimeMessage(session);
        MimeMultipart msgMimeMultipart = new MimeMultipart("mixed"); //mixed为混合类型
        //这只邮件类型为混合型以添加附件
        msg.setContent(msgMimeMultipart);
        //设置发件人
        msg.setFrom(new InternetAddress(FROM));
        
        //设置收件人为多位时，可用逗号隔开
        
        msg.setRecipients(RecipientType.TO,InternetAddress.parse(invoiceMail.getAddressTo()));
        
        //设置邮件回复
        InternetAddress[] replyAdd = {new InternetAddress(MimeUtility.encodeText(FROM)+"<"+FROM+">")}; 
        msg.setReplyTo(replyAdd);
        
       //设置邮件主题 
        String fileName ="";
        String subject = "";
        sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
        String orderNo = invoiceMail.getOrderNo();
        String tourCode = "";
        if(invoiceMail.getTourCode()!=null&&invoiceMail.getTourCode().length()!=0){
        	tourCode = "("+invoiceMail.getTourCode()+")";
        }
        String lineName = invoiceMail.getLineName();
        if(invoiceMail.getIOrV()==1){//如果数值为1：则产生invoice
        	if(tourCode!=null&&tourCode!=""){
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo);
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo);
        	}else{
        		subject = MimeUtility.encodeText("(文景假期)invoice-"+orderNo);
        		fileName = MimeUtility.encodeText("(文景假期)invoice-"+orderNo);
        	}
        	
        }
        msg.setSubject(subject);
        
        //准备附件
       BodyPart fileurl = new MimeBodyPart();
        //将附件设置到msgMimeMultipart中
        msgMimeMultipart.addBodyPart(fileurl);
        
        //给附件设置内容
        
        DataSource fileurlContent = new FileDataSource(invoiceMail.getDestPath());
       //向附件内添加数据
        fileurl.setDataHandler(new DataHandler(fileurlContent));
        
        //为保证文件名不会乱码
        
        fileurl.setFileName(fileName+".pdf");
        
       // MimeMultipart bodyMultipart = new MimeMultipart("ralated");
        Transport.send(msg);
        
    }
    
}
